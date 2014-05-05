class Profession < ActiveRecord::Base
  def self.creatable?
    true
  end
end
