print "Enter the date in 'dd.mm.yyyy' format: "
input = gets.chomp
date = input.split('.').map(&:to_i)
day, month, year = date
leap = (year % 4) == 0 && (year % 100) != 0 || (year % 400) == 0
days_in_february = leap ? 29 : 28
days_in_months = [0, 31, days_in_february, 31, 30, 31, 30, 31, 31, 30,
                  31, 30, 31]
index = day + days_in_months[0...month].inject(:+)
puts "#{input} is #{index}th day of the year"
