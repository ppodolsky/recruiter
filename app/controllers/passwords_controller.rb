class PasswordsController < Devise::PasswordsController
  def create
    user = User.find_by_email(resource_params[:email])
    raw, enc = Devise.token_generator.generate(user.class, :reset_password_token)
    user.reset_password_token   = enc
    user.reset_password_sent_at = Time.now.utc
    user.save(:validate => false)
    UserMailer.delay.reset_password_instructions(user, raw)
    flash[:notice] = "Email with instructions has been sent to #{resource_params[:email]}"
    redirect_to root_path
  end
end