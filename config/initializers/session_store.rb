# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_nodemap_session',
  :secret      => 'b0805598654ccddb7caf943849c37c68856e37f7e20744b4a7055f9e96d2fcf04d565fe603f63176196f9895bdab4ded624d53b51809dda8dda7743c08ad1e94'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
