require File.dirname( __FILE__ ) + '/../../config/environment'
require 'run_cmd'

TARGETS = %w[ production staging ]

namespace :heroku do

  desc "Back up DB from production to localhost"
  task :backup => %w[ heroku:pull db:backup ]

  desc "Clone DB from production to localhost"
  task :pull do
    target = ENV['TARGET'] || TARGETS.first
    run "rake db:drop db:create RAILS_ENV=#{Rails.env}"
    run "heroku db:pull --app #{app}-#{target} --confirm #{app}-#{target}"
  end

  desc "Clone DB from production to localhost"
  task :push do
    target = ENV['TARGET'] || raise( 'please pass in TARGET')
    raise 'Refusing to push db to production' if target=='prod' || target=='production'
    run "heroku run:rake db:reset --app #{app}-#{target}"
    run "heroku db:push --app #{app}-#{target} --confirm #{app}-#{target}"
  end

  desc "Deploy from REF=<ref> TARGET=<#{TARGETS.join('|')}>"
  task :deploy => :environment do
    ref = ENV['REF'] || 'HEAD'
    target = ENV['TARGET'] || TARGETS.first
    deploy( target, ref )
    run( "heroku run:rake --trace db:migrate                 --app #{app}-#{target}" )
    run( "heroku restart                                 --app #{app}-#{target}" )
    run( "heroku run:rake --trace db:seed                    --app #{app}-#{target}" )
  end

  def deploy( target, ref )
    # add remote in case this dev box doesn't have it yet, makes it easier to track, eg in gitx
    git_remote = "heroku-#{app}-#{target}"
    unless `git remote`.match( /\b#{git_remote}\b/ )
      run( "git remote add #{git_remote} git@heroku.com:#{app}-#{target}.git" )
    end

    # deploy release branch: always *to* heroku "master" branch
    run( "git push --force #{git_remote} #{ref}:master" )
  end

  desc 'make new app instance on heroku using TARGET=<eg static1>'
  task :create do
    the_name = ENV[ 'TARGET' ] || raise( 'Please pass in TARGET=<eg static1>' )
    heroku_app = "#{app}-#{the_name}"
    [
      "heroku create #{heroku_app} --stack bamboo-mri-1.9.2",
      "heroku addons:add custom_domains --app #{heroku_app}",
    ].each { |cmd| run( cmd, :continue_on_failure => true ) }

    [ '', 'www.' ].each do |subdomain|
      run( "heroku domains:add #{subdomain}#{app}.org --app #{heroku_app}", :confirm_first => true )
    end
  end

  def app
    ENV[ 'APP' ] || File.expand_path( Rails.root ).split( '/' ).last
  end

end
