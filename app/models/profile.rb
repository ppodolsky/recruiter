class Profile < ActiveRecord::Base
  has_paper_trail

  belongs_to :user, :class_name => 'Subject', inverse_of: :profile

  validates_presence_of :gender, :birth_year,
    :ethnicity, :years_resident, :class_year, :year_started,
    :current_gpa, :phone, :major, :profession, presence: true

  validates :secondary_email, format: { with: /\A[^@]+@[^@]+\z/, message: 'Not a valid e-mail address.' }
  validates :secondary_email, uniqueness: true, allow_blank: true

  normalize_attributes :secondary_email
end
