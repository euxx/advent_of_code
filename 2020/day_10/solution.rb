input = File.readlines("./2020/day_10/input.txt")

numbers = input.map { |line| line.delete("\n").to_i }.sort

# Part One

combinations = numbers.zip([0] + numbers[0..-2])
differences = combinations.map { |x, y| x - y }

count_diff_1 = differences.count(1)
count_diff_3 = differences.count(3) + 1

result = count_diff_1 * count_diff_3

puts "Part One - The puzzle answer is #{result}"

# Part Two

diff_1_count_group = [] # A group of contiguous_diff_1 count
diff_1_count = 0
last_index = differences.size - 1

differences.each_with_index do |number, index|
  if number == 1
    diff_1_count += 1
    diff_1_count_group << diff_1_count if index == last_index
  else
    diff_1_count_group << diff_1_count if diff_1_count > 1
    diff_1_count = 0
  end
end

ways_count_group = diff_1_count_group.map do |count|
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
