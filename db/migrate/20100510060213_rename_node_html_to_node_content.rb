class RenameNodeHtmlToNodeContent < ActiveRecord::Migration
  def self.up
    rename_column(:nodes, :html, :content)
  end

  def self.down
    rename_column(:nodes, :content, :html)
  end
end
