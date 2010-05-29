class CreateNodes < ActiveRecord::Migration
  def self.up
    create_table :nodes do |t|
      t.string   "key"
      t.text     "content", :limit => 1.megabyte  
      t.timestamps
    end
  end

  def self.down
    drop_table :nodes
  end
end
