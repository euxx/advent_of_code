input = File.readlines("./2020/day_02/input.txt")

passwords = input.map do |line|
  limit, char, value = line.split(' ')
  min, max = limit.split('-').map(&:to_i)

  [char[0], min, max, value]
end

# Part One

valid_passwords = passwords.select do |char, min, max, value|
  (min..max).include?(value.count(char))
end

result = valid_passwords.size

puts "Part One - The puzzle answer is #{result}"

# Part Two

valid_passwords = passwords.select do |char, min, max, value|
  [value[min-1] == char, value[max-1] == char].uniq.size == 2
end

result = valid_passwords.size

puts "Part Two - The puzzle answer is #{result}"
