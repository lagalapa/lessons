properties = []
sides = []

print 'Enter side a: '
sides << gets.to_f
print 'Enter side b: '
sides << gets.to_f
print 'Enter side c: '
sides << gets.to_f

if sides.uniq.size == 1
  properties << 'equilateral'
elsif sides.uniq.size == 2
  properties << 'isosceles'
end

if sides.count(sides.max) == 1
  max_side = sides.delete(sides.max)
  properties << 'rectangular' if max_side**2 == sides[0]**2 + sides[1]**2
end

properties << 'common' if properties.empty?

puts 'The triangle is:'
properties.each { |x| puts x }
