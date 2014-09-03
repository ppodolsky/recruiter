class Category < ActiveRecord::Base

  has_and_belongs_to_many :experiments

  alias_attribute :name, :tag

  def self.creatable?
    true
  end
end
