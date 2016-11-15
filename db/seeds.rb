# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
def main
  create_default_api_key
end

def create_default_api_key
  ApiKey.find_or_initialize_by(key: "foobar", name: "docs").save!
end

main
puts "For development start with api_key: foobar"
