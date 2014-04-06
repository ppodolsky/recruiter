class Subject < User
  validates_presence_of :gender, :birth_year,
                        :ethnicity, :years_resident, :class_year, :year_started,
                        :current_gpa, :phone, :major, :profession, presence: true
end
