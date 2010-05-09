task :relate => :create_relationships
task :create_relationships  => :environment do
  NodeMap.create_relationships
end

