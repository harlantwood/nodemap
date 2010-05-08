class Node < ActiveRecord::Base   

  has_many :relationships
  has_many :related_nodes, :through => :relationships
  
  validates_presence_of   :key
  validates_uniqueness_of :key
  validates_presence_of   :html
  
  def to_param
    URI::escape( key )
  end
end
