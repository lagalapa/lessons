print "Enter a: "
a = gets.to_f
print "Enter b: "
b = gets.to_f
print "Enter c: "
c = gets.to_f
roots = []
discriminant = b**2 - 4 * a * c
if discriminant >= 0
  roots << (-b + Math.sqrt(discriminant)) / (2 * a)
  roots << (-b - Math.sqrt(discriminant)) / (2 * a)
else roots << "no roots"
end

puts "Roots: "
roots.uniq.each { |root| puts root }