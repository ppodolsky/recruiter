class Subject < User
  has_many :registrations
  has_many :sessions, through: :registrations

  has_many :assignments
  has_many :experiments, through: :assignments

  attr_reader :attendance, :never_been

  validates_presence_of :gender, :birth_year,
                        :ethnicity, :years_resident, :class_year, :year_started,
                        :current_gpa, :phone, :major, :profession, presence: true

  def attendance
    registrations.count != 0 ? registrations.where(shown_up: true).count / registrations.count : 100
  end
  def never_been
    registrations.where(shown_up: true).count == 0
  end
  def registrations_count
    attributes['registrations_count']
  end
  def shown_up_count
    attributes['shown_up_count']
  end
end
