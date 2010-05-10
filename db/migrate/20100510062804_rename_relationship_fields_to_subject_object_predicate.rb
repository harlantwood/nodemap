class RenameRelationshipFieldsToSubjectObjectPredicate < ActiveRecord::Migration
  def self.up
    # rename_column(:relationships, :node_id,         :subject_id)
    rename_column(:relationships, :content_id,      :predicate_id)
    # rename_column(:relationships, :related_node_id, :object_id)
  end

  def self.down
  end
end
