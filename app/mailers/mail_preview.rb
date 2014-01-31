class MailPreview < MailView
  def confirmation
    record = User.create! email: 'user@example.org', password: 'example_pass'
    mail = UserMailer.confirmation_instructions(record, record.confirmation_token)
    record.destroy
    mail
  end

  def reset
    record = User.create! email: 'user@example.org', password: 'example_pass'
    Devise.token_generator.generate(User, :reset_password_token)
    mail = UserMailer.reset_password_instructions(record, record.reset_password_token)
    record.destroy
    mail
  end

  def unlock
    record = User.create! email: 'user@example.org', password: 'example_pass'
    record.lock_access!
    Devise.token_generator.generate(User, :unlock_token)
    mail = UserMailer.unlock_instructions(record, record.unlock_token)
    record.destroy
    mail
  end
end
