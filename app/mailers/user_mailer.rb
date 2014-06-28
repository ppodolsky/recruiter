require 'kramdown'
class UserMailer < Devise::Mailer
  @@host = 'ices-recruiter-staging.com'
  default from: 'noreply@' + @@host

  def confirmation_instructions(user, token, opts={})
    send_from_db(user.email, Recruiter::Application.routes.url_helpers.user_confirmation_url(user, :confirmation_token => token, :host => @@host), 'confirm')
  end
  def reset_password_instructions(user, token, opts={})
    send_from_db(user.email, Recruiter::Application.routes.url_helpers.user_reset_url(user, :reset_token => token, :host => @@host), 'reset')
  end
  def unlock_instructions(user, token, opts={})
    send_from_db(user.email, Recruiter::Application.routes.url_helpers.user_unlock_url(user, :unlock_token => token, :host => @@host), 'unlock')
  end
  def send_from_db(email, url, template_name, opts = {})
    template = Email.find(template_name).value
    subject = Email.find(template_name).subject
    template.gsub!('@email', email)
    template.gsub!('@url', url) if url.present?
    headers = {
        :subject       => subject,
        :content_type => 'text/html',
        :to            => email,
        :body => Kramdown::Document.new(template).to_html.html_safe
    }.merge(opts)
    mail headers
  end
  def deactivation(user)
    send_from_db(user.email, nil, 'unlock')
  end
  def invite_to_register(email)
    send_from_db(email, nil, 'invite')
  end
  def invitation(user, experiment)
    template = experiment.default_invitation
    template.gsub!('@name', user.name)
    template.gsub!('@reward', "#{experiment.reward}$")
    template.gsub!('@timeline_url', timeline_url)
    template.gsub!('@session_list', "\n" + experiment.sessions.map {|x| "* #{x.start_time_display}"}.join("\n") + "\n")
    mail(:to => user.email,
         :content_type => 'text/html',
         :subject => 'ICES Experiment Invitation',
         :body => Kramdown::Document.new(template).to_html.html_safe)
  end
end
