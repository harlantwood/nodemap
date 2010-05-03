class CreateNodes < ActiveRecord::Migration
  def self.up
    create_table :nodes do |t|
      t.string   "key"
      t.text     "html"  
      t.timestamps
    end
  end

  def self.down
    drop_table :nodes
  end
end
