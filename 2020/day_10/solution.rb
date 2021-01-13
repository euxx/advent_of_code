input = File.readlines("./2020/day_10/input.txt")

numbers = input.map(&:to_i).sort

# Part One

differences = [0, *numbers, numbers.max + 3].each_cons(2).map { |x, y| y - x }

result = differences.count(1) * differences.count(3)

puts "Part One - The puzzle answer is #{result}"

# Part Two

ways_count_group = differences.join.scan(/1+/).map do |ones|
  count = ones.size
  max = count - 2
  count + (1 + max) * max / 2
end

result = ways_count_group.reduce(:*)

puts "Part Two - The puzzle answer is #{result}"

#2 1 2 3         = 1 + 1       0
#3 1 2 3 4       = 1 + 2 + 1   1
#4 1 2 3 4 5     = 1 + 3 + 3   2 + 1
#5 1 2 3 4 5 6   = 1 + 4 + 6   3 + 2 + 1
#6 1 2 3 4 5 6 7 = 1 + 5 + 10  4 + 3 + 2 + 1
