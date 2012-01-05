require 'run_cmd'

task :deploy => :environment do
  app = File.expand_path( Rails.root ).split( '/' ).last
  ref = ENV['REF'] || 'master'
  # deploy release branch: always *to* heroku "master" branch 
  run "git push --force heroku #{ref}:master"
  run "heroku rake --trace db:migrate --app #{app}"
  run "heroku restart                 --app #{app}"
end


