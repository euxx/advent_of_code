input = File.readlines("./2020/day_01/input.txt")

numbers = input.map(&:to_i)

# Part One

array_two = numbers.product(numbers)
the_pair = array_two.find { |x, y| x + y == 2020 }

result = the_pair.inject(:*)

puts "Part One - The puzzle answer is #{result}"

# Part Two

array_three = array_two.product(numbers)
the_three = array_three.find { |(x, y), z| x + y + z == 2020 }

result = the_three.flatten.inject(:*)

puts "Part Two - The puzzle answer is #{result}"
