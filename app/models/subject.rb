class Subject < User
  has_many :registrations
  has_many :sessions, through: :registrations

  has_many :assignments
  has_many :experiments, through: :assignments

  has_one :profile

  attr_reader :attendance
  def attendance
    registrations.where(shown_up: true).count / registrations.count if registrations.count != 0
  end
end
