module Devise
  module Models
    module Recoverable
      def reset_password!(new_password, new_password_confirmation)
        self.password = new_password
        self.password_confirmation = new_password_confirmation

        clear_reset_password_token
        after_password_reset

        save(validate: false)
      end
    end
  end
end
