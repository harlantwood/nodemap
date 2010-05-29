class CreateNodes < ActiveRecord::Migration
  def self.up
    create_table :nodes do |t|
      t.string   "key"
      t.text     "content"  #, :limit => 1.megabyte   # NOTE!  we truncate content in mysql, but this 'limit' crashes on postgres.  postgres allows at least 1 MB, probably more.
      t.timestamps
    end
  end

  def self.down
    drop_table :nodes
  end
end
