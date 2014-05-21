require "CSV"
items = [] 
subtotal = 0  
input = nil

def read_csv(items)
  i = 1
  CSV.foreach("products.csv", headers: true) do |entry|
    items << {item_number: i, name: entry[1], price: entry[3], sku: entry[0]}
    i += 1 
  end
end

def prompt(items, subtotal) 
  puts "Please select an item number. Press 4 to check out or any other key to continue.\n \n"
  items.each {|item| puts "##{item[:item_number]} - #{item[:name]} - $#{item[:price]}"}
  puts "#4 - Complete Sale"
  make_selection(items, subtotal)
end 

def make_selection(items, subtotal)
  input = gets.chomp.to_i
  items.each do |item| 
  	if input == item[:item_number]
  	  puts "You've selected #{item[:name]}.  How many would you like?"
  	  quantity = gets.chomp.to_i
  	  assign_quantities(item, quantity)
  	  subtotal += item[:price].to_f * item[:quantity_sold] 
      puts "Current subtotal: $#{subtotal}."
      puts "Press 4 to checkout, or any other key to continue"
  	  input = gets.chomp.to_i
  	  input != 4 ? prompt(items, subtotal) : give_change(subtotal) 
  	end
  end
end

def assign_quantities(item, quantity)
  item[:quantity_sold] = quantity
end

def display_time
  time = Time.new
  puts time.strftime("%m/%d/%y at %H:%M")
end

def accept_payment
  payment = gets.chomp.to_f
end

def give_change(subtotal)
  puts "Your total today is $#{subtotal}.  Cash tendered: "
  change = (accept_payment - subtotal).round(2)
  if change > 0 
    puts "Your change is $#{change.abs}, thank you!" 
    display_time
  elsif change == 0
	  puts "Exact change, thanks!"
	  display_time
  else
	  puts "You still owe $#{change.abs}."
  end
end

def write_receipt(items)
  CSV.open("receipt.csv", "w") do |row|
    row << ["SKU", "Name", "Price", "Quantity Sold"]
    items.each do |item| 
        row << ["#{item[:sku]}", "#{item[:name]}", "#{item[:price]}", "#{item[:quantity_sold]}" ]
    end #Important to insert ALL values into a row, not just a single one
  end  #Must insert them as strings!
end 

puts "Welcome to James' Coffee Emporium! \n \n"
read_csv(items)
prompt(items, subtotal)
write_receipt(items)

#test







