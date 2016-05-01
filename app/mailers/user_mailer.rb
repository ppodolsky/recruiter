require 'kramdown'
require 'mail'

class UserMailer < Devise::Mailer
  @@host = 'experiments.gmu.edu'
  default from: 'postmaster@ices-experiments.com'
  def templatize(template, opts = {})
    RestClient.post "https://api:key-fed7ecf70b27cb44ca211a50139b4f98"\
    "@api.mailgun.net/v3/ices-experiments.com/messages",
    opts.each_pair do |e,v|
      template.gsub!("@#{e}", v)
    end
    template
  end
  def confirmation_instructions(user, token, opts={})
    RestClient.post "https://api:key-fed7ecf70b27cb44ca211a50139b4f98"\
    "@api.mailgun.net/v3/ices-experiments.com/messages",
    send_from_db(user.email, 'confirm', 'name'=> user.name, 'url' => Recruiter::Application.routes.url_helpers.user_confirmation_url(:confirmation_token => token, :host => @@host))
  end
  def reset_password_instructions(user, token, opts={})
    RestClient.post "https://api:key-fed7ecf70b27cb44ca211a50139b4f98"\
    "@api.mailgun.net/v3/ices-experiments.com/messages",
    email = user.email
    email = user.secondary_email if opts[:secondary_email].present? and opts[:secondary_email]
    send_from_db(email, 'reset', 'name'=> user.name, 'url' => Recruiter::Application.routes.url_helpers.edit_user_password_url(:reset_password_token => token, :host => @@host))
  end
  def unlock_instructions(user, token, opts={})
    send_from_db(user.email, 'unlock', 'name'=> user.name, 'url' => Recruiter::Application.routes.url_helpers.user_unlock_url(:unlock_token => token, :host => @@host))
  end
  def send_custom(email, subject, template, opts = {})
    RestClient.post "https://api:key-fed7ecf70b27cb44ca211a50139b4f98"\
    "@api.mailgun.net/v3/ices-experiments.com/messages",
    message = templatize(template, opts)
    headers = {
        :subject       => subject,
        :content_type => 'text/html',
        :to            => email,
        :body => Kramdown::Document.new(message).to_html.html_safe
    }.merge(opts)
    mail headers
  end
  def registered_on_session(user, session, opts = {})
    RestClient.post "https://api:key-fed7ecf70b27cb44ca211a50139b4f98"\
    "@api.mailgun.net/v3/ices-experiments.com/messages",
    send_from_db(user.email, 'registered_on_session', 'session' => session.to_s, 'name' => user.name)
  end
  def remind_about_session(session)
    RestClient.post "https://api:key-fed7ecf70b27cb44ca211a50139b4f98"\
    "@api.mailgun.net/v3/ices-experiments.com/messages",
    session.users.pluck(:email).each do |email|
      send_from_db(email, 'remind', 'session' => session.to_s)
    end
  end
  def send_from_db(email, template_name, opts = {})
    RestClient.post "https://api:key-fed7ecf70b27cb44ca211a50139b4f98"\
    "@api.mailgun.net/v3/ices-experiments.com/messages",
    e = Email.find(template_name)
    send_custom(email, e.subject, e.value, opts)
  end
  def experimenter_invitation(experiment, email_list, subject_for_mail, template)
    RestClient.post "https://api:key-fed7ecf70b27cb44ca211a50139b4f98"\
    "@api.mailgun.net/v3/ices-experiments.com/messages",
    send_custom(experiment.creator.email, subject_for_mail, template + "\n\n*Email list:*\n\n" + email_list ,
                'reward' => "$#{experiment.reward}",
                'timeline_url' => timeline_url,
                'name' => experiment.creator.name,
                'session_list' => "\n" + experiment.sessions.where(reservation: false).where(finished: false).where('registration_deadline > ?', Time.now).map {|x| "* #{x.to_s}"}.join("\n") + "\n")
  end
  def unsuspend(user)
    RestClient.post "https://api:key-fed7ecf70b27cb44ca211a50139b4f98"\
    "@api.mailgun.net/v3/ices-experiments.com/messages",
    send_from_db(user.email, 'unsuspend', 'name'=> user.name, 'url'=>'http://' + @@host)
  end
  def suspend(user)
    RestClient.post "https://api:key-fed7ecf70b27cb44ca211a50139b4f98"\
    "@api.mailgun.net/v3/ices-experiments.com/messages",
    send_from_db(user.email, 'suspend', 'name'=> user.name, 'url'=>'http://' + @@host)
  end
  def deactivation(user)
    RestClient.post "https://api:key-fed7ecf70b27cb44ca211a50139b4f98"\
    "@api.mailgun.net/v3/ices-experiments.com/messages",
    send_from_db(user.email, 'deactivation', 'name'=> user.name, 'url'=>'http://' + @@host)
  end
  def invitation(user, experiment, subject_for_mail, template)
    RestClient.post "https://api:key-fed7ecf70b27cb44ca211a50139b4f98"\
    "@api.mailgun.net/v3/ices-experiments.com/messages",
    send_custom(user.email, subject_for_mail, template,
                'reward' => "$#{experiment.reward}",
                'timeline_url' => timeline_url,
                'name' => user.name,
                'session_list' => "\n" + experiment.sessions.where(reservation: false).where(finished: false).where('registration_deadline > ?', Time.now).map {|x| "* #{x.to_s}"}.join("\n") + "\n")
  end
end
