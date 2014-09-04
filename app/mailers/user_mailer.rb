require 'kramdown'
class UserMailer < Devise::Mailer
  @@host = 'www.ices-experiments.org'
  default from: 'noreply@ices-experiments.org'

  def confirmation_instructions(user, token, opts={})
    send_from_db(user.email, Recruiter::Application.routes.url_helpers.user_confirmation_url(:confirmation_token => token, :host => @@host), 'confirm')
  end
  def reset_password_instructions(user, token, opts={})
    send_from_db(user.email, Recruiter::Application.routes.url_helpers.edit_user_password_url(:reset_password_token => token, :host => @@host), 'reset')
  end
  def unlock_instructions(user, token, opts={})
    send_from_db(user.email, Recruiter::Application.routes.url_helpers.user_unlock_url(:unlock_token => token, :host => @@host), 'unlock')
  end
  def send_from_db(email, url, template_name, opts = {})
    if opts[:immediate].present?
      template = opts[:immediate]
    else
      template = Email.find(template_name).value
    end
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
  def deactivation(user, email_text)
    send_from_db(user.email, 'http://' + @@host, 'unlock', immediate: email_text)
  end
  def invite_to_register(email, email_text)
    send_from_db(email, 'http://' + @@host, 'invite', immediate: email_text)
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
