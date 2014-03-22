class Subject < User
  has_many :registrations
  has_many :sessions, through: :registrations

  has_many :assignments
  has_many :experiments, through: :assignments

  has_one :profile, :foreign_key => 'user_id'

  attr_reader :attendance, :never_been
  def attendance
    registrations.where(shown_up: true).count / registrations.count if registrations.count != 0 else "Hasn't reigistred yet"
  end
  def never_been
    registrations.where(shown_up: true).count == 0
  end
  def self.full
    Subject.new(profile: Profile.new(major: %w[M F]))
  end
end
