class ApiApplicationController < ActionController::Base
#reviewed: done
	private
	
		def validate_authentication_token
			user = User.find_by_email(params[:email])
			if @user .nil?
				render :json => '{"error": "invalid email and token combination"}'
				return
			end
			if !@user .valid_authentication_token(params[:token])
				render :json => '{"error": "invalid email and token combination"}'
				return
			end
			if @user.suspended      
				render :json => '{"error": "Your account has been suspended. Contact to administrator to deal with it."}'	
				return
			end
		end
		
end