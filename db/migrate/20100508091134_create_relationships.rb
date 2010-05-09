class CreateRelationships < ActiveRecord::Migration
  def self.up
    create_table :relationships do |t|
      t.integer :node_id
      t.integer :related_node_id
      t.integer :content_id
      t.timestamps
    end
  end

  def self.down
    drop_table :relationships
  end
end