print 'Enter your name: '
name = gets.chomp
print 'Enter your height: '
height = gets.to_f
ideal_weight = height - 110
if ideal_weight >= 0
  puts "#{name}, your ideal weight is #{ideal_weight}"
else
  puts "#{name}, grow up a little"
end
