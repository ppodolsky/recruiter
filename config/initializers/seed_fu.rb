SeedFu.quiet = true if ENV['RAILS_ENV'] == 'production'

# SeedFu is confused. Fixtures should be handled by the test suite.
SeedFu.fixture_paths.reject! { |i| i.match(/fixtures/) }

if ENV['RAILS_ENV'] == 'development'
  SeedFu.fixture_paths.unshift(
    File.expand_path(Rails.root.join('db','samples')),
    File.expand_path(Rails.root.join('db','samples',ENV['RAILS_ENV']))
  )
end

SeedFu.fixture_paths.unshift(
  File.expand_path(Rails.root.join('db','seeds')),
  File.expand_path(Rails.root.join('db','seeds',ENV['RAILS_ENV']))
)
