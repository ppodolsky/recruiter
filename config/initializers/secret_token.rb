# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.

Recruiter::Application.config.secret_key_base = Settings.secret_token || '4178db188c4156a5fcca19ee8f6f915e34e8da45e36f2e2daa5250676a6084e8299157be7ef13befa0e1e8fffeb06fe1b992189bf2212515ab8d543cc17a1e64'

if Rails.env.production? && Recruiter::Application.config.secret_key_base.blank?
  raise 'SECRET_TOKEN environment variable must be set!'
end
