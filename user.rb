require 'pry'
require 'json'
# require './atm'
class User
  attr_accessor :id, :name, :password, :balance

  def initialize(id: nil, name: nil, password: nil, balance: 0)
    @id = id
    @name = name
    @password = password
    @balance = balance
  end

  def save!
    if File.open('users.json', 'a+').read == ""
      @id = 1
    else
      users = JSON.parse(File.read('users.json'))
      @id = users.last["id"] + 1
    end

    user={"id"=>@id, "name"=>name, "password"=>password, "balance"=>balance.to_i}
    if File.open('users.json', 'a+').read == ""
      File.write('users.json', JSON.dump([user])) # new user creation when db empty
    else
      users = JSON.parse(File.read('users.json'))
      users << user
      File.write('users.json', JSON.dump(users)) # new user creation when db has value
    end


    # File.open("users.json","a+") do |f|
    #   f.write(user.to_json)
    #   f.write("\n")
    # end
    # File.write('users.json', JSON.dump(user))
    # File.write('users.json', JSON.dump("\n"))

  end
  def interface
    options = [
      "1- Create User",
      "2- Sign in",
      "3- Exit",
    #"4- Return to Menu"
    ]
    puts "Select options from below\n" + options.join("\n")

    case gets.chomp
    when '1'
      puts "For creating a new User fill this info\n"
      puts "User name(String): "
      name = gets.chomp
      puts "User password(String): "
      password = gets.chomp
      puts "User balance(Integer): "
      balance = gets.chomp
      User.new(name: name,balance: balance, password: password).save!
      users = JSON.parse(File.read('users.json'))
      binding.pry
      puts users
    when '2'
      puts "Your Name: "
      name = gets.chomp
      puts "Your password: "
      password = gets.chomp
      users = JSON.parse(File.read('users.json'))

      check1 = users.select{|x| x["name"] == name}
      check2 = users.select{|x| x["password"] == password}
      if check1 == check2
        user = check1.first
        # account = Atm.new(atm)
      else
        puts "Wrong User Name or Password"
      end
    when '3'
      puts "Transaction ends"
      exit 0
    else
      "Wrong option. Try again."
    end
  end
end

# User.new(name: 'abir',balance: 1000, password: 'abir12').save!
#
# user={ "id"=>10, "name"=>'abir111', "password"=>'abir111', "balance"=>200000}
# File.write('users.json', JSON.dump(user), 'a+')



