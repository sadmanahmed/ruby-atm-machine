
require 'pry'

class User
  attr_reader :args

  def initialize(**args)
    @args = args
  end
  binding.pry
  def save!
    users_db.write({ id: find_id, name: args[:name]}.to_json)
    users_db.write("\n")
  end

  def find_id
    binding.pry
    users_db.read.split('\n').last[:id]  + 1
  end

  def users_db
    File.open('users.json', 'a+')
  end
end

User.new(id: 1, name: 'Istiak').save!
