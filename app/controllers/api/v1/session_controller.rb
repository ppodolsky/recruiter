class Api::V1::SessionController < ApiApplicationController

	before_filter :validate_authentication_token, only: [:join] 
	
	def join
		session = Session.find(params[:session_id])
		join = true
		join_text = ''
		if session.users.size < session.required_subjects
			if @user.sessions.where('start_time < ? and end_time > ?', session.end_time, session.start_time).count == 0
				@user.sessions << session
			else
				join = false
				join_text = 'You have another session at this time'
			end
		else
			join = false
			join_text = 'This session is now full'
		end		
		render :json=> {
						:session    => session, 
						:user  		=> @user, 						
						:join  		=> join, 
						:join_text  => join_text,					
					}	
	end
	
end