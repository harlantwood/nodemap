namespace :db do
  task :rebuild => %w[ environment drop create migrate seed ]
end
