# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_tefter_session',
  :secret      => 'e22fe3e5ac3983e6999fd5462287c4698906f39ecb329005089f4ce5a4dc419e2546813e002725cac1ef1800e1a3005c9f7c93837a243364ce9692676484ae33'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
