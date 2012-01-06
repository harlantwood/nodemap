class Node < ActiveRecord::Base

  has_many :relationships, :foreign_key => 'subject_id'

  validates_presence_of   :key
  validates_uniqueness_of :key
  validates_presence_of   :content

  def Node.recent( max_nodes )
    Node.find( :all, :order => 'updated_at DESC', :limit => max_nodes )
  end

  def Node.custom_find_or_create( content )
    key = content.sha512
    node = Node.find_by_key( key ) 
    node = Node.create!( :key => key, :content => content ) unless node
    node.reload
    raise "Correct key is #{key}, but was stored as #{node.key}" unless node.key == key
    node
  end

  def to_param
    URI::escape( key )
  end

end
