products = {}
total_result = 0

loop do
  print 'Enter the name of the product: '
  product_name = gets.chomp
  break if product_name == 'stop'
  print 'Enter the quantity: '
  quantity = gets.to_f
  print 'Enter the price: '
  price = gets.to_f
  products[product_name] = { quantity: quantity, price: price }
end

products.each do |product, attrs|
  quantity = attrs[:quantity]
  price = attrs[:price]
  total_price = quantity * price
  puts "Product: #{product}, quantity: #{quantity}, price: #{price},"\
       "total price: #{total_price}"
  total_result += total_price
end
puts "The whole purchase price: #{total_result}"
