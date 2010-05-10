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

  def Node.recent_with_title( max_nodes )
    Node.recent( max_nodes ).select( &:title )
  end

  def Node.custom_find_or_create( content )
    key = Digest::SHA1.hexdigest( content ) 
    node = Node.find_by_key( key ) 
    unless node
      node = Node.create!( :key => key, :content => content )
      node.create_relationships
    end
    node   
  end

  def initialize( params = nil )
    if params.nil? or params.keys.map( &:to_s ).sort == %w[ content key ]
      super( params )
    else
      raise "Unexpected params passed to Node.new: #{params.inspect} -- you may want Node.custom_find_or_create(...), or Node.new()" 
    end
  end

  def to_param
    URI::escape( key )
  end

  def to_s      
    plain_text? ? content : key
  end         
  
  def plain_text?
    ! content.match( %r{<html.+</html>}im )
  end
  
  def create_relationships
    doc = Nokogiri::HTML( content )                
    %w[ div.title h1 ].each do |selector|
      if ( title_elements = doc.search( selector ) ).length == 1
        self.add_related_node( 'title', title_elements.first.content ) 
        break
      end
    end

    # ::: Wikipedia categories :::
    # doc.search( 'div#catlinks > div > span > a' ).each do |category_link_tag| 
    #   node.add_tag( category_link_tag.content ) 
    # end
  end

  def title                          
    relationship = relationships.to_a.find{ |relationship| relationship.predicate.content == 'title' }   # note: finds the first one!  do something smarter.
    relationship.object.content if relationship
  end

  def add_related_node( predicate, object_content )
    object_node = Node.custom_find_or_create( object_content )
    predicate_node = Node.custom_find_or_create( predicate )
    puts Relationship.create!( :subject => self, :predicate => predicate_node, :object => object_node )
  end

end
