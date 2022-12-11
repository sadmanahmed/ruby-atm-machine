require 'pry'
require './user'
class Atm
  # use this portion to override the json after withdraw,deposit,transfer
  # File.write('users.json', JSON.dump(users))
  user = User.new.interface
  exit 0 if user.nil?
  @users = JSON.parse(File.read('users.json'))
  @rest_users = @users - [user]
  # loop do
    options = [
      "1- Deposit",
      "2- Withdraw",
      "3- Check balance",
      "4- Transfer",
      "5- Exit"
    ]
    puts "Select options from below\n" + options.join("\n")
    case gets.chomp
    when '1'
      puts "How many dollars do you want to deposit?"
      # You could merge these lines into account.deposit(get.chomp.to_f)
      amount = gets.chomp.to_i
      user["balance"] += amount
      @rest_users << user
      File.write('users.json', JSON.dump(@rest_users))
      # we have to update the whole json again
      #
    when '2'
      puts "How many dollars do you want to withdraw?"
      # You could merge these lines into account.deposit(get.chomp.to_f)
      amount = gets.chomp.to_i
      user["balance"] -= amount
      @rest_users << user
      File.write('users.json', JSON.dump(@rest_users))
      # we have to update the whole json again
    when '3'
      puts "User Name #{user["name"]} & Balance #{user["balance"]}"
    when '4'
      puts "Transfer Account Name: "
      name = gets.chomp
      puts "Transfer Account ID: "
      id = gets.chomp.to_i
      check1 = @rest_users.select{|x| x["name"] == name}
      check2 = @rest_users.select{|x| x["id"] == id}
      if check1 == check2
        transfer_user = check1.first
        puts "Transfer amount"
        amount = gets.chomp.to_i
        if user["balance"] >= amount
          user["balance"] -= amount
          transfer_user["balance"] += amount
        end
        # rest_users = @rest_users - [transfer_user]
        # rest_users << transfer_user
        @rest_users << user
        File.write('users.json', JSON.dump(@rest_users))
      else
        puts "Wrong transfer User Name or ID"
      end
    when '5'
      puts "Transaction ends"
      exit 0
      #break
    else
      "Wrong option. Try again."
    end
end
