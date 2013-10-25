class Profile < ActiveRecord::Base
  belongs_to :user, inverse_of: :profile
  validates :user, presence: true

validates :first_name, :last_name, :gender, :age, :ethnicity,
    :years_resident, :class_year, :total_years, :year_started, :current_gpa,
    :phone, presence: true

  validates :secondary_email, format: { with: /\A[^@]+@[^@]+\z/, message: 'Not a valid e-mail address.' }
  validates :secondary_email, uniqueness: true

  normalize_attributes :secondary_email

  [:first_name, :last_name, :profession, :ethnicity, :class_year].each do |attribute|
    normalize_attribute attribute do |value|
      value.is_a?(String) ? value.titleize.strip : value
    end
  end
end
