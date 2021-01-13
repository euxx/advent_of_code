input = File.readlines("./2020/day_09/input.txt")

numbers = input.map(&:to_i)

# Part One

only_number = numbers.each_cons(26).find do |*prev_nums, number|
  prev_nums.combination(2).all? { _1.sum != number }
end.last

result = only_number

puts "Part One - The puzzle answer is #{result}"

# Part Two

i1, i2 = 0, 0

loop do
  sum = numbers[i1..i2].sum
  break if sum == only_number && i1 < i2

  sum > only_number ? i1 += 1 : i2 += 1
end

result = numbers[i1..i2].minmax.sum

puts "Part Two - The puzzle answer is #{result}"
