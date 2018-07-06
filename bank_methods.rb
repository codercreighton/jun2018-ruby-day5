#class for creating accounts
class Account
	attr_reader :name, :account_number
	attr_accessor :balance

	def initialize(name, balance, account_number)
		@name = name
		@balance = balance
		@account_number = account_number
	end
	
	def deposit(amount)
		@balance += amount
	end	

	def withdraw(amount)
		@balance -=amount
	end	

end	



def main_menu
	puts "Welcome to Creighton Bank!"
	puts "Please make a selection below:"
	puts "------------------------------"
	puts "1. Create an account"
	puts "2. View Account Info"
	puts "0. Exit the System"

	option = gets.chomp.to_i

	case option 
		when 1
			create_account
		when 2
			view_account	
		when 0
			puts "Thank you for banking with us!"
			exit
		else
			puts "That is an invalid entry.  Please try again."		
			main_menu
	end			
end

def create_account
	account_number = @accounts.length

	puts "Let's create your account.  Please provide the name on the account:"
	name = gets.chomp.upcase
	puts "What is the starting balance?"
	starting_balance = gets.chomp.to_f

	new_account = Account.new(name, starting_balance, account_number)
	@accounts.push(new_account)

	puts "The following account has been created:"
	puts "Account Number #{account_number}"
	puts "Name on Account: #{name}"
	puts "Balance: #{starting_balance}"

	puts new_account.inspect

	puts "\n"
	main_menu

end	

def view_account

	tries = 0
	found = false

	while tries < 3
		puts "Please login to your account to view information and make transactions"
		puts "Enter name on the account: "
		name = gets.chomp.upcase
		puts "Enter the account number: "
		account_number = gets.chomp.to_i
		balance = 0 

		@accounts.each do |account|
			if account.name == name && account.account_number == account_number
				balance = account.balance
				found = true
				tries = 3
				break
			end		
		end	

		if found == false
			tries +=1
			puts "Login information incorrect.  Please try again. Tries left #{3 - tries}"
			
		else
			puts "Your account has been found."
			account_menu(name, balance, account_number)
		end	
	end	

end	



def account_menu(name, balance, account_number)
	puts "Welcome #{name}!  Here is your account menu."
	puts "Choose an option from below:"
	puts "-------------------------------"
	puts "1. View account balance"
	puts "2. Make a deposit"
	puts "3. Make a withdrawal"
	puts "4. Return to Main Menu"

	option = gets.chomp.to_i

	case option
		when 1
			puts "Your current balance is $#{balance}."
			puts "\n"
			account_menu(name, balance, account_number)
		when 2
			make_deposit(name, balance, account_number)	
		when 3
			make_withdrawal(name, balance, account_number)
		when 4
			puts "Exiting the Account Menu. Returning to Main Menu..."	
			main_menu
		else
			puts "Invalid entry.  Please choose again."
			account_menu(name, balance, account_number)		
	end		

end	

def make_deposit(name, balance, account_number)
	puts "How much would you like to deposit?"
	deposit_amount = gets.chomp.to_f
	new_balance = 0


	@accounts.each do |account|
		if account.name == name && account.account_number == account_number
			account.deposit(deposit_amount)
			new_balance = account.balance
		end	
	end	

	puts "You deposit of $#{deposit_amount} was made to your account."
	puts "Your previous balance was $#{balance}.  Your new balance is $#{new_balance}"

	account_menu(name, new_balance, account_number)	
end


def make_withdrawal(name, balance, account_number)
	tries = 0
	insufficient = true
	new_balance = 0

	while tries < 3
		puts "How much do you want to withdraw?"
		withdraw_amount = gets.chomp.to_f

		if withdraw_amount > balance
			tries +=1
			
			puts "Your balance of $#{balance} is insufficient for the withdraw amount of $#{withdraw_amount}.  Please enter another amount. You have #{3 - tries} remaining."
		else
			tries = 3
			insufficient = false
		end	
	end


	if insufficient == false
		@accounts.each do |account|
			if account.name == name && account.account_number == account_number
				account.withdraw(withdraw_amount)
				new_balance = account.balance
			end	
		end
		puts "Your withdraw of $#{withdraw_amount} has been made. Your previous balance was $#{balance}, your new balance is $#{new_balance}."
		account_menu(name, new_balance, account_number)
	else
	 puts "You seem to be having trouble.  Please contact Bank staff for help!  Returning to Main menu..."		

	 
	 main_menu
	end 

end	


