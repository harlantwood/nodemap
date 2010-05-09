task :relate => :create_relationships
task :create_relationships  => :environment do
  Node.all.each(&:create_relationships)
end