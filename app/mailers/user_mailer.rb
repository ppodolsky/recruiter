require 'kramdown'

class UserMailer < Devise::Mailer
  default from: 'noreply@ices-recruiter-staging.com'

  def confirmation_instructions(record, token, opts={})
    super
  end
  def reset_password_instructions(record, token, opts={})
    super
  end
  def unlock_instructions(record, token, opts={})
    super
  end
  def deactivation(user)
    mail(:to => user.email, :subject => 'ICES Account Deactivation')
  end
  def invite_to_register(email)
    mail(:to => email, :subject => 'ICES Recruiter')
  end
  def invitation(user, experiment)
    template = experiment.default_invitation
    template.gsub!('@name', user.name)
    template.gsub!('@reward', "#{experiment.reward}$")
    template.gsub!('@timeline_url', timeline_url)
    template.gsub!('@session_list', "\n" + experiment.sessions.map {|x| "* #{x.start_time_display}"}.join("\n") + "\n")
    mail(:to => user.email, :content_type => 'text/html', :subject => 'ICES Experiment Invitation', :body => Kramdown::Document.new(template).to_html.html_safe)
  end
end
