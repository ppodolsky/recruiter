class Settings < Settingslogic
  source "#{Rails.root}/config/application.yml"
  namespace Rails.env # where can we find settings in the above file?
  suppress_errors Rails.env.production? # transparent in production
  load! # this prevents collision with capistrano, vlad, and friends
end
