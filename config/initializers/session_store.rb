# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_hackety-hack.com_session',
  :secret      => 'ece97651a250c7b3341bedc9bee4d6903e665d6a9c4c341871caec0f641c9a1256eb20f6fb8df710df2556714cc7d669c6352b6726b49f5ddb7939a5871a027c'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
