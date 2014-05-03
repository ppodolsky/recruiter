class Lab < ActiveRecord::Base
  has_many :sessions
  alias_attribute :name, :location

  def self.creatable?
    true
  end
end
