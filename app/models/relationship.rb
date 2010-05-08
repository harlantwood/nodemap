class Relationship < ActiveRecord::Base
  belongs_to :node
  belongs_to :related_node, :class_name => 'Node'
end
