input = File.read("./2020/day_02/input.txt")

passwords = input.scan(/(\d+)-(\d+) (\w): (\w+)/)

# Part One

result = passwords.count do |min, max, char, value|
  value.count(char).between?(min.to_i, max.to_i)
end

puts "Part One - The puzzle answer is #{result}"

# Part Two

result = passwords.count do |min, max, char, value|
  (value[min.to_i-1] == char) != (value[max.to_i-1] == char)
end

puts "Part Two - The puzzle answer is #{result}"
