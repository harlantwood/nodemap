class ChangeNodeContentToLargerSize < ActiveRecord::Migration
  def self.up
    change_column(:nodes, :content, :text, :limit => 1.megabyte)
  end

  def self.down
    change_column(:nodes, :content, :text, :limit => 64.kilobytes)
  end
end
