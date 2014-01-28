User.where(username: nil).each do |u|
  u.set_canonical_name
end
