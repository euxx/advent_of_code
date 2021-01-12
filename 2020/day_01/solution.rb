input = File.readlines("./2020/day_01/input.txt")

NUMBERS = input.map(&:to_i)

def calc(n) = NUMBERS.combination(n).find { _1.sum == 2020 }.reduce(:*)

# Part One

result = calc(2)

puts "Part One - The puzzle answer is #{result}"

# Part Two

result = calc(3)

puts "Part Two - The puzzle answer is #{result}"
