class Session < ActiveRecord::Base
  has_paper_trail
  belongs_to :experiment
  belongs_to :lab, inverse_of: :sessions
  has_many :registrations
  has_many :subjects, through: :registrations
  validate :check_time_range
  validates :required_subjects, numericality: { only_integer: true, greater_than: 0 }

  def check_time_range
    if (end_time - duration).to_i < start_time.to_i
      errors.add(:end_time, "cannot be lesser than start time with duration")
    end
    if registration_deadline > start_time
      errors.add(:registration_deadline, "cannot be lesser than start time")
    end
  end
end
