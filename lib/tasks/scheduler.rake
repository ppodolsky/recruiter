desc "This task is called by the Heroku scheduler add-on"

task :send_reminders => :environment do
  sessions = Session.where('remind_at < ?', Time.now).where(reminded: false)
  sessions.each do |session|
    UserMailer.delay.remind_about_session(session)
  end
  sessions.update_all(reminded: true)
end