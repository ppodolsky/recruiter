Devise::Async.setup do |config|
  config.enabled = true # useful for debugging in development
  config.backend = :delayed_job # Supported options: :resque, :sidekiq, :delayed_job, :queue_classic, :torquebox
  config.queue   = :mail
end
