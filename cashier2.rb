puts "Please enter item prices: "   #prompts for item prices
input = gets.chomp
charges = []

def total(array)
  array.inject(0) {|total, each| total + each}
end

until input.downcase == "done"
  charges << input.to_f
  subtotal = "Current subtotal of $#{total(charges)}."
  puts subtotal #returns a running subtotal for each
  input = gets.chomp
end

charges.each {|amount| puts "$#{amount}"} #at "done" returns a list of all prices entered
puts "$#{total(charges)} due."  #also returns total due

puts "Cash tendered: " #prompts for cash tendered
payment = gets.chomp
change = (payment.to_f - total(charges)).round(2)
time = Time.new
if change > 0 
  puts "Your change is $#{change.abs}, thank you!" #calculates change due and date/time
  puts time.strftime("%m/%d/%y at %H:%M")
elsif change == 0
	puts "Exact change, thanks!"
else
	puts "You still owe $#{change.abs}."
end

 