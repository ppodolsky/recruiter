
guard 'spork', :rspec_env => { 'RAILS_ENV' => 'test' } do
  watch('config/application.rb')
  watch('config/environment.rb')
  watch(%r{^config/environments/.+\.rb$})
  watch(%r{^config/initializers/.+\.rb$})
  watch('Gemfile')
  watch('Gemfile.lock')
  watch('spec/spec_helper.rb') { :rspec }
end

guard :bundler do
  watch('Gemfile')
  # Uncomment next line if your Gemfile contains the `gemspec' command.
  # watch(/^.+\.gemspec/)
end

guard 'rails' do
  watch('Gemfile.lock')
  watch(%r{^(config|lib)/.*})
end

guard 'livereload' do
  watch(%r{app/views/.+\.(erb|haml|slim)$})
  watch(%r{app/helpers/.+\.rb})
  watch(%r{public/.+\.(css|js|html)})
  watch(%r{config/locales/.+\.yml})
  # Rails Assets Pipeline
  watch(%r{(app|vendor)(/assets/\w+/(.+\.(css|js|html|png|jpg))).*}) { |m| "/assets/#{m[3]}" }
end

guard :rspec, all_on_start: false, all_after_pass: false, cmd: 'bundle exec rspec --drb --color --format Fuubar' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^app/controllers/(.+)\.rb$})               { |match| ["spec/features/", "spec/controllers/#{match[1]}_spec.rb"] }
  watch(%r{^app/models/(.+)\.rb$})                    { |match| ["spec/models/#{match[1]}_spec.rb", "spec/decorators/#{match[1]}_decorator_spec.rb"] }
  watch(%r{^app/decorators/(.+)\.rb$})                { |match| "spec/decorators/#{match[1]}_spec.rb" }
  watch(%r{^app/views/(.+\.(erb|haml|slim))$})        { |match| "spec/views/#{match[1]}_spec.rb" }
  watch(%r{^app/views/(.+)/.*\.(erb|haml|slim)$})     { |match| "spec/features/#{match[1]}_spec.rb" }
  watch('app/controllers/application_controller.rb')  { ["spec/features", "spec/controllers"] }
  watch(%r{^app/helpers/(.+)\.rb$})                   { |match| "spec/helpers/#{match[1]}_spec.rb"}
  watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }
  watch('spec/spec_helper.rb')                        { "spec" }

  watch('config/routes.rb')                           { ["spec/routing", "spec/features"] }
end

guard 'delayed', :environment => 'development', command: 'bin/delayed_job' do
  watch(%r{^app/(.+)\.rb})
end
