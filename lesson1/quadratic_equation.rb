print "Enter a: "
a = gets.to_i
print "Enter b: "
b = gets.to_i
print "Enter c: "
c = gets.to_i
roots = []
d = b**2 - 4 * a * c
if d >= 0
  roots << (-b + Math.sqrt(d)) / (2 * a)
  roots << (-b - Math.sqrt(d)) / (2 * a)
else roots << "no roots"
end

puts "Roots: "
roots.uniq.each { |x| puts x }