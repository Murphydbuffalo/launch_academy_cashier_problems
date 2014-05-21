


#prompted for amount due
puts "How much does the customer owe?"
bill = gets.chomp.to_f.round(2)
#prompted for amount received
puts "How much did the customer pay?"
payment = gets.chomp.to_f.round(2)
#gives change and time of transaction or provides message and exits if not enough is provided
change = (payment-bill).abs
#if payment > bill return the difference of the two and the time
if payment > bill
  puts Time.new
  puts "Your change is $#{change}!"
#else warn cashier payment is insufficient and exit
elsif payment == bill
  puts "Exact change! Much appreciated."
else
  puts "Sorry you still owe $#{change}!"
end
  

