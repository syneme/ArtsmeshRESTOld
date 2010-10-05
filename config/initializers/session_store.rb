# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_ArtsmeshRest.2_session',
  :secret      => '417e3ca1af80f20838f0d58febfcce08691688560b91d2e50d716f010cf6fdf264627aac986d79a899a3b79008ee1133f5e45849c80e1ffbbb0ae2957112ef42'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
