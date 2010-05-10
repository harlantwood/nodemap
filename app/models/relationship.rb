class Relationship < ActiveRecord::Base
  belongs_to :node
  belongs_to :related_node, :class_name => 'Node'
  belongs_to :content,      :class_name => 'Node'
  
  validates_presence_of :node
  validates_presence_of :related_node
  validates_presence_of :content
  
  def to_s
    "#{node.key}[#{content.html}] = #{related_node.html}"
  end
end
