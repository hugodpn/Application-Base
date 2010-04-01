# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_application_session',
  :secret      => '1ad19468ebb6221882e077c08cbbf8fa4f096658d3a5fd48a3faf0e4944d60234bb834bec634cd30f475d105fab148f8f5e7a4c0fd98ea6ef6b5dedd8e1b5efc'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
