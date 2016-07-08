lass Api::V1::CalendarController < ApiApplicationController

	before_filter :validate_authentication_token, only: [:index]

	def index
	    @incoming = @user
			.sessions
			.includes(:experiment => :creator)
			.where(start_time: DateTime.strptime(params[:start],'%s')..DateTime.strptime(params[:end],'%s'))
			.where(finished: false).order('start_time ASC')
			
		@opened = Session
			.includes(:experiment => :creator)
			.where(start_time: DateTime.strptime(params[:start],'%s')..DateTime.strptime(params[:end],'%s'))
			.where(reservation: false)
			.where(finished: false)
			.where(experiment_id: @user.experiments)
			.where('registration_deadline > ?', Time.now)
			.where.not(id: @user.sessions)
			.where.not(experiment_id: @user.current_experiments)
			.where.not(experiment_id: @user.participated_experiments)
			.order('start_time ASC')			
			
		arrsessions = []
		@opened.each do |session|
			join = true
			join_text = ''
			if session.users.size < session.required_subjects
				if @user.sessions.where('start_time < ? and end_time > ?', session.end_time, session.start_time).count != 0
					join = false
					join_text = 'You have another session at this time'
				end
			else
				join = false
				join_text = 'This session is now full'
			end		

			arrsessions << {
					:session => session,
					:include => {
						:experiment => session.experiment,
						:lab => session.lab
					},
					:join => join,
					:join_text => join_text,	
				}	
							
		end	
		
		arrsessionsincom = []
		@incoming.each do |sessionincom|
			arrsessionsincom << {
					:session => sessionincom,
					:include => {
						:experiment => sessionincom.experiment,
						:lab => sessionincom.lab
					}
				}			
		end	

		
		render :json => 		{
			:incoming  => arrsessionsincom,
			:opened  		=> arrsessions, 			
		}
	end
end