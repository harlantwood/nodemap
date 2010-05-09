require 'shell'; include Shell            

task :deploy => :environment do
  app = File.expand_path( Rails.root ).split( '/' ).last
  ref = ENV['REF'] || 'master'
  # deploy release branch: always *to* heroku "master" branch 
  execute( "git push --force heroku #{ref}:master" ) 
  execute( "heroku rake --trace db:migrate --app #{app}" )
  execute( "heroku restart                 --app #{app}" )
end


