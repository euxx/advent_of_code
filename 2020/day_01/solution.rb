input = File.readlines("./2020/day_01/input.txt")

numbers = input.map(&:to_i)

# Part One

the_pair = numbers.combination(2).find { |pair| pair.sum == 2020 }

result = the_pair.inject(:*)

puts "Part One - The puzzle answer is #{result}"

# Part Two

the_three = numbers.combination(3).find { |three| three.sum == 2020 }

result = the_three.inject(:*)

puts "Part Two - The puzzle answer is #{result}"
