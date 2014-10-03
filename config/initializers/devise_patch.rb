module Devise
  module Models
    module Recoverable
      def reset_password!(new_password, new_password_confirmation)
        user = self.becomes(User.class)
        user.password = new_password
        user.password_confirmation = new_password_confirmation

        if user.valid?
          user.clear_reset_password_token
          user.after_password_reset
        end

        user.save
      end
    end
  end
end
