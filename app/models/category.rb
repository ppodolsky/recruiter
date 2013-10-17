class Category < ActiveRecord::Base
  has_and_belongs_to_many :experiments, :join_table => :categories_experiments
  normalize_attributes :tag
end
