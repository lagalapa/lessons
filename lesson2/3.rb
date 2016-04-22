array = [1, 1]
fib_num = 2
while fib_num <= 100
  array << fib_num
  fib_num = array[-1] + array[-2]
end
