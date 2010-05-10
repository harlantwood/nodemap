class Relationship < ActiveRecord::Base
  belongs_to :subject,   :class_name => 'Node'
  belongs_to :object,    :class_name => 'Node'
  belongs_to :predicate, :class_name => 'Node'
  
  validates_presence_of :subject
  validates_presence_of :object
  validates_presence_of :predicate
  
  def to_s
    "#{subject.key}[#{predicate.content}] = #{object.content}"
  end
end
