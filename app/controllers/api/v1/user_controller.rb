class Api::V1::UserController < ApiApplicationController
#user controller = reviewed
	before_filter :validate_authentication_token, only: [:index, :update_account, :update_personal, :update_education]
	
def login
  user = User.find_by_email(params[:email])
  ethnicity = Ethnicity.all
  profession = Profession.all
  major = Major.all
  if user .nil?
   render :json => {
    :error "invalid email and password combination not user",
    :email => params[:email],
    :password => params[:password]
   }
  else
   if user .valid_password? params[:password]
    if user.suspended      
     render :json => '{"error": "Your account has been suspended. Contact to administrator to deal with it."}' 
     return
    end
    if user.confirmed?
     user.generate_authentication_token
     render :json=> {
      :success    => true, 
      :auth_token => user.token, 
      :user       => user, 
      :ethnicity  => ethnicity, 
      :profession => profession,
      :major      => major     
     }
    else
     render :json => '{"error": "You have to confirm your account before continuing."}'    
    end
   else
    render :json => {
     :error "invalid email and password combination not valid pswd",
     :email => params[:email],
     :password => params[:password]     
    }
   end
  end    
 end
 
	def index
		ethnicity = Ethnicity.all
		profession = Profession.all
		major = Major.all
		render :json=> {
						:user       => @user, 
						:ethnicity  => ethnicity, 
						:profession => profession,
						:major      => major					
					}
	end
	
	def update_account
	
		@user.first_name = params[:firstName]
		@user.last_name = params[:lastName]
		@user.gsharp = params[:g]	
		@user.save(validate: false)
		
		if params[:newPassword].present?	
			password_length = params[:newPassword].length
			if password_length < 6 || password_length > 9
				render :json => {
						status: "error",
						error: "Password must be no less than 6 and no more than 9 characters"
					}				
			else
				if(params[:newPassword] == params[:confirmPassword])
					
					if @user .valid_password? params[:currentPassword]
						
						@user.password = params[:newPassword]
						@user.save(validate: false)
						render :json => {status: "ok"}	
					else
						render :json => {
								status: "error",
								error: "Incorrect current password"
							}	
					
					end	 
				else
					render :json => {
							status: "error",
							error: "Incorrect confirm password"
						}		
				end
			end
		else
			render :json => {status: "ok"}			
		end	
	end
	
	def update_personal
	
		@user.gender = params[:gender]
		@user.birth_year = params[:birthYear]
		@user.profession = params[:profession]
		@user.ethnicity = params[:ethnicity]
		@user.years_resident = params[:yearsResident]
		@user.save(validate: false)			
		render :json => {status: "ok"}	
	end
	
	def update_education
	
		@user.class_year = params[:classYear]
		@user.year_started = params[:yearStarted]
		@user.current_gpa = params[:currentGPA]
		@user.major = params[:major]			
		@user.save(validate: false)	
		render :json => {status: "ok"}	

	end
	
	def registration
		user = User.find_by_email(params[:email])
		if user .nil?
			if params[:firstName].length < 1
				render :json => {
					status: "error",
					error: "Incorrect first name"
				}	
				return				
			end
			if params[:lastName].length < 1
				render :json => {
					status: "error",
					error: "Incorrect last name"
				}
				return				
			end
			if params[:g].length < 1
				render :json => {
					status: "error",
					error: "Incorrect gsharp"
				}
				return			
			end
			if params[:email].length < 1
				render :json => {
					status: "error",
					error: "Incorrect gsharp"
				}	
				return
			end
			password_length = params[:password].length
			if password_length < 6 || password_length > 9
				render :json => {
						status: "error",
						error: "Password must be no less than 6 and no more than 9 characters"
					}	
					return						
			end
			if params[:password] == params[:passwordConfirm]
				#user = User.new
				#user.first_name = params[:firstName]
				#user.last_name = params[:lastName]
				#user.gsharp = params[:g]	
				#user.password = params[:password]
				#user.save(validate: false)
				render :json => {status: "ok"}
			else
				render :json => {
						status: "error",
						error: "Incorrect confirm password"
					}
					return
			end
		else
			render :json => {
					status: "error",
					error: "Incorrect email"
				}
				return
		end	
	end
  
	
end