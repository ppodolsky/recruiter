class Profile < ActiveRecord::Base
  has_paper_trail

  belongs_to :user, inverse_of: :profile

  validates_presence_of :user, :first_name, :last_name, :gender, :birth_year,
    :ethnicity, :years_resident, :class_year, :year_started,
    :current_gpa, :phone, :major, presence: true

  validates :secondary_email, format: { with: /\A[^@]+@[^@]+\z/, message: 'Not a valid e-mail address.' }
  validates :secondary_email, uniqueness: true, allow_blank: true

  normalize_attributes :secondary_email

  [:first_name, :last_name, :profession, :ethnicity, :class_year].each do |attribute|
    normalize_attribute attribute do |value|
      value.is_a?(String) ? value.titleize.strip : value
    end
  end
end
