require 'kramdown'
class UserMailer < Devise::Mailer
  @@host = 'experiments.gmu.edu'
  default from: 'no-reply@ices-experiments.org'
  def templatize(template, opts = {})
    template.scan(/(?<!\w)@\w+/).each do |sub|
      template.gsub!(sub, opts[sub[1..-1]]) if opts[sub[1..-1]].present?
    end
    template
  end
  def confirmation_instructions(user, token, opts={})
    send_from_db(user.email, 'confirm', 'url' => Recruiter::Application.routes.url_helpers.user_confirmation_url(:confirmation_token => token, :host => @@host))
  end
  def reset_password_instructions(user, token, opts={})
    email = user.email
    email = user.secondary_email if opts[:secondary_email].present? and opts[:secondary_email]
    send_from_db(email, 'reset', 'url' => Recruiter::Application.routes.url_helpers.edit_user_password_url(:reset_password_token => token, :host => @@host))
  end
  def unlock_instructions(user, token, opts={})
    send_from_db(user.email, 'unlock', 'url' => Recruiter::Application.routes.url_helpers.user_unlock_url(:unlock_token => token, :host => @@host))
  end
  def send_custom(email, subject, template, opts = {})
    message = templatize(template, opts)
    headers = {
        :subject       => subject,
        :content_type => 'text/html',
        :to            => email,
        :body => Kramdown::Document.new(message).to_html.html_safe
    }.merge(opts)
    mail headers
  end
  def registered_on_session(email, session, opts = {})
    send_from_db(email, 'registered_on_session', 'session' => session.to_s)
  end
  def remind_about_session(session)
    send_from_db(session.users.pluck(:email), 'remind', 'session' => session.to_s)
  end
  def send_from_db(email, template_name, opts = {})
    e = Email.find(template_name)
    send_custom(email, e.subject, e.value, opts)
  end
  def invitation(email, experiment, subject_for_mail, template)
    send_custom(email, subject_for_mail, template,
                'reward' => "#{experiment.reward}$",
                'timeline_url' => timeline_url,
                'session_list' => "\n" + experiment.sessions.where(reservation: false).where(finished: false).where('registration_deadline > ?', Time.now).map {|x| "* #{x.to_s}"}.join("\n") + "\n")
  end
end
