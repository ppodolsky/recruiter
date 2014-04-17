class Session < ActiveRecord::Base
  belongs_to :experiment
  belongs_to :lab, inverse_of: :sessions
  has_many :registrations, :dependent => :delete_all
  has_many :subjects, class_name: 'User', through: :registrations

  validate :check_time_range
  validates :required_subjects, numericality: { only_integer: true, greater_than: 0 }
  validates_presence_of :lab

  def check_time_range
    if (start_time.advance(hours: duration.hour, minutes: duration.min) > end_time)
      errors.add(:end_time, "cannot be lesser than start time with duration")
    end
    if registration_deadline > start_time
      errors.add(:registration_deadline, "cannot be later than start time")
    end
    t = Session.where('start_time <= ? and ? <= end_time and lab_id = ?', self.end_time, self.start_time, self.lab_id)
    t.each do |f|
      errors.add(:selected_time, "is overlapping with the session of #{f.experiment.name} (from #{f.start_time.strftime("%d %B %Y at %H:%M")} to #{f.end_time.strftime("%d %B %Y at %H:%M")})")
    end
  end
end