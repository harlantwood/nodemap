require 'digest/sha1'
require 'nokogiri'

class Node < ActiveRecord::Base   

  has_many :relationships, :foreign_key => 'subject_id'

  validates_presence_of   :key
  validates_uniqueness_of :key
  validates_presence_of   :content

  def Node.recent( max_nodes )
    Node.find( :all, :order => 'updated_at DESC', :limit => max_nodes )
  end

  def Node.custom_find_or_create( content )
    key = Digest::SHA1.hexdigest( content ) 
    node = Node.find_by_key( key ) 
    unless node
      node = Node.create!( :key => key, :content => content )
    end
    node
  end

  def to_param
    URI::escape( key )
  end

end
