User.seed do |s|
  s.id = 1
  s.email = 'admin@example.com'
  s.encrypted_password = ''
  s.confirmed_at = Date.time.now
end
