class Major < ActiveRecord::Base
  def self.creatable?
    true
  end
end
