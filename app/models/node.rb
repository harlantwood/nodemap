require 'nokogiri'
require 'digest/sha1'

class Node < ActiveRecord::Base   

  has_many :relationships
  has_many :related_nodes, :through => :relationships
  
  validates_presence_of   :key
  validates_uniqueness_of :key
  validates_presence_of   :html
  
  def Node.recent( max_nodes )
    Node.find( :all, :order => 'updated_at DESC', :limit => max_nodes )
  end
   
  def Node.recent_with_title( max_nodes )
    Node.recent( max_nodes ).select( &:title )
  end
  
  def Node.custom_find_or_create( html )
    key = Digest::SHA1.hexdigest( html ) 
    Node.find_or_create_by_key( :key => key, :html => html )
  end
  
  def initialize
    raise 'please use Node.custom_find_or_create( ... )'
  end
  
  def to_param
    URI::escape( key )
  end

  def to_s      
    if title
      "#{title}"
    else
      "[#{html}]"
    end
  end
  
  def title                          
    relationship = relationships.to_a.find{ |relationship| relationship.content.html == 'title' }   # note: finds the first one!  do something smarter.
    relationship.related_node.html if relationship
  end
  
  def add_related_node( relationship_content, html )
    related_node = Node.custom_find_or_create( html )
    relationship_content_node = Node.custom_find_or_create( relationship_content )
    Relationship.create!( :node => self, :related_node => related_node, :content => relationship_content_node )
  end
  
end
