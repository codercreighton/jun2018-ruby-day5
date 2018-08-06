# Ruby Step-by-Step Program Homework
# Build an inventory program for a Grocery Store. The program should allow the manager to:

# View Categories of products

# Each category by default should contain 5 items.

# View an individual product

# Change the quantity of a product

# Add products to any category.

# A product should be an object created from a class. Each category should be its own type. Each product should have the base properties of:

# name

# quantity

# serial number

# cost

# sell price

# Other features to think about:

# Add "sell by" dates to each product

# Have it so the manager can see how many items need to be sold within the week.

# List it out by product.

# Determine how much

# each product cost the store to purchase

# each product could bring in in revenue

# each product would make in profit

# Create the ability to put an item on sale, or take an item off sale. Determine the sale discount.

#Create a Product Class
require 'Date'

class Product
	attr_reader :name, :serial_number, :category
	attr_accessor  :quantity, :cost, :sell_price, :sell_by

	def initialize(name, category, quantity, serial_number, cost, sell_price, sell_by)
		@name = name
		@category = category
		@quantity = quantity
		@serial_number = serial_number
		@cost = cost
		@sell_price = sell_price
		@off_sale = sell_price
		@sell_by = sell_by
	end	

	def shelf_life
		if @sell_by >= Date.today
			puts "Shelflife is #{(@sell_by - Date.today).to_i} days"
		else
			puts "Item has passed it's shelflife by #{(Date.today - @sell_by).to_i} days"	
		end
	end	

	def change_quantity(amount)
		@quantity += amount
	end	

	def sell_price
		@sell_price
	end	


	def profit
		(@sell_price * quantity) - (@cost * quantity)
	end	

	def sale(amount)
		@sell_price = amount
	end	

	def off_sale
		@sell_price = @off_sale
	end	

	def revenue
		@sell_price * quantity
	end	



end

def add_products
	puts "How many products would you like to add?"
	prod_num = gets.chomp.to_i

	prod_num.times do
		puts "Product name:"
		name = gets.chomp.upcase
		puts "quantity: "
		quantity = gets.chomp.to_i
		puts "category (meat, fruit, dry goods, or dairy):"
		category = gets.chomp.upcase
		puts "cost: "
		cost = gets.chomp.to_f
		puts "sell price: "
		sell_price = gets.chomp.to_i
		serial_number = "#{name[0..2]}-#{category[0..2]}".upcase
		puts "What is the sell_by date? (YYYY-MM-DD)"
		sell_by =  Date.parse(gets.chomp)

		new_product = Product.new(name, category, quantity, serial_number, cost, sell_price, sell_by)
		case new_product.category
			when "FRUIT"
				@fruit.push(new_product)
			when "MEAT"
				@meat.push(new_product)
			when "DAIRY"
				@dairy.push(new_product)
			when "DRY GOODS"
				@dry_goods.push(new_product)
		end
		puts "The following product has been added: NAME: #{name}, QUANTITY: #{quantity}, CATEGORY: #{category}, SERIAL_NUMBER: #{serial_number}, COST: #{cost}, SELL PRICE: #{sell_price}."				
	end
	main_menu	
end



def main_menu
	puts "Welcome to the Grocery Inventory System"
	puts "Choose an option"
	puts "----------------------------------------"
	puts "1. Enter a product"
	puts "2. View all products"
	puts "3. View/Modify product info"
	puts "4. Exit System"

	option = gets.chomp.to_i

	case option
		when 1 
			add_products
		when 2
			view_products
		when 3
		 modify_product
		when 4
			puts "You are now exiting the system."
			exit
		else
		 	puts "Invalid entry"
		 	main_menu
	end	 	
end

def view_products

	puts "What category would you like to see? "
	category = gets.chomp.upcase

	case category
	when "FRUIT"
		show_category(@fruit)
	when "MEAT"
		show_category(@meat)	
	when "DAIRY"
		show_category(@dairy)
	when "DRY GOODS"
		show_category(@dry_goods)

	else
		puts "Invalid entry, try again."
		main_menu					

	end
end	

def show_category(array)
	if array.length > 0
		array.each do |n|
			puts n.name, n.serial_number
		end
		main_menu
	else
		puts "There are no products to display."	
		main_menu
	end	
end	


def modify_product
	puts "Please enter the category of the product you'd like to see:"
	category = gets.chomp.upcase

	puts "Enter the serial number of the product you want to modify: "
	serial = gets.chomp.upcase

	if category == "FRUIT"
		find_product(@fruit, serial)
	elsif category == "MEAT"
		find_product(@meat, serial)
	elsif category == "DAIRY"
		find_product(@dairy, serial)
	elsif category == "DRY GOODS"
		find_product(@dry_goods, serial)	
	else
		puts "Invalid category. Please choose meat, dairy, or fruit or dry goods."
		modify_product
	end

end 	




 def find_product(array, serial)
		check = false



		array.each do |n|
			if n.serial_number == serial
				check = true
			end
		end	



		if check == true
			modify_menu(array, serial)
		else
				puts "That serial number is not in the system."
				main_menu		
		end		

 end

def modify_menu(array,serial)
	array.each do |n|
		if n.serial_number == serial
			puts "Here are options for #{n.serial_number}(#{n.name}) "
			puts "Choose an option:"
			puts "-----------------------------------------------------"
			puts "1. View product's cost to store for purchase"
			puts "2. View product's potential revenue"
			puts "3. View product's potential profit"
			puts "4. Put an item on sale"
			puts "5. Take item off sale"
			puts "6. Determine shelf life"
			puts "7. View the sell price"
			puts "8. Change quantity"
			puts "9. Return to Main Menu"

			choice = gets.chomp.to_i

			if choice == 1
				puts "#{n.name}'s cost to store is #{n.cost}."
				modify_menu(array,serial)
			elsif choice == 2
				puts "#{n.name}'s potential revenue is #{n.revenue}."
				modify_menu(array,serial)
			elsif choice == 3
				puts "#{n.name}'s potential profit is #{n.profit}."
				modify_menu(array,serial)
			elsif choice == 4
				puts "What is the sale price?"
				sale = gets.chomp.to_f
				puts "The new price with sale is #{n.sale(sale)}"
			modify_menu(array,serial)
			elsif choice == 5
				puts "The sale has been removed. The original price of #{n.off_sale} is now active."	
			modify_menu(array,serial)
			elsif choice == 6 
				n.shelf_life
				modify_menu(array,serial)
			elsif choice == 7
				puts "The sell price of #{n.name} is #{n.sell_price}."	
				modify_menu(array,serial)	
			elsif choice == 8
				puts "What is the new quantity for #{n.name}?"	
				amount = gets.chomp.to_i
				n.change_quantity(amount)
				puts "The new quanity for #{n.name} is #{n.quantity}"
				modify_menu(array,serial)		

			elsif choice == 9
			 	main_menu
			else
				puts "Invalid choice!"
				modify_menu(array,serial)
			end	 					
		end								
	end	
end

#------------------------------------------------------------------#


@fruit = []
@dairy = []
@meat = []
@dry_goods = []


system('clear')

main_menu



