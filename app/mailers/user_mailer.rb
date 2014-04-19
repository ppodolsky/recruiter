class UserMailer < Devise::Mailer
  def confirmation_instructions(record, token, opts={})
    super
  end
  def reset_password_instructions(record, token, opts={})
    super
  end
  def unlock_instructions(record, token, opts={})
    super
  end
end
