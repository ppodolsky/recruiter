# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

%w[Economics Psychology Sociology Science/Engineering Math Other].each do |feature|
  Major.create({ name: feature })
end
ClassYear.create([{ name: 'Freshman', year: 1 },
                  {name: 'Sophomore', year: 2},
                  {name: 'Junior', year: 3},
                  {name: 'Senior', year: 4},
                  {name: 'Graduate Student', year: 5}])
(['Part-time student', 'Full time student', 'University staff', 'Faculty', 'Visiting student', 'Other']).each do |feature|
  Profession.create({ name: feature })
end
(['White', 'Black', 'Asian', 'Hispanic', 'Other']).each do |feature|
  Ethnicity.create({ name: feature })
end
