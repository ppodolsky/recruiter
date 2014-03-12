class Subject < User
  has_and_belongs_to_many :sessions
end
