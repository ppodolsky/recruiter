namespace :db do
  desc "drops, creates, migrates, and seeds database"
  task :nuke_pave => :environment do
    unless Rails.env == "Production"
      Rake::Task["db:drop"].execute
      Rake::Task["db:create"].execute
      Rake::Task["db:migrate"].execute
      Rake::Task["db:seed"].execute
    end
  end
end
