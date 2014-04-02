class Session < ActiveRecord::Base
  has_paper_trail
  belongs_to :experiment
  belongs_to :lab, inverse_of: :sessions
  has_many :registrations
  has_many :subjects, through: :registrations
  validate :check_time_range
  validates :required_subjects, numericality: { only_integer: true, greater_than: 0 }

  def check_time_range
    if (start_time.advance(:hours => duration.hour, :minutes => duration.min) > end_time)
      errors.add(:end_time, "cannot be lesser than start time with duration")
    end
    if registration_deadline > start_time
      errors.add(:registration_deadline, "cannot be later than start time")
    end
  end
end
