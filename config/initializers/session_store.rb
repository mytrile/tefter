# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_piggybank_session',
  :secret      => '239f265612cb347cc8f4b177c58031e794c58de64cce3033255b1ca25fe9118a59d7e68c133d0ee7e90b8c84e3e6107aba128a6f400c9313162bf07c1185366f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
