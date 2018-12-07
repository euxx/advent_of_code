FREQUENCIES = File.readlines("./input.txt")

# Part One

resulting_frequency = FREQUENCIES.sum(&:to_i)

puts "Part One - Resulting frequency is #{resulting_frequency}"

# Part Two

current_frequency = 0
hash = Hash.new(0)

frequencies = FREQUENCIES.cycle
until hash[current_frequency] == 2
  current_frequency += frequencies.next.to_i
  hash[current_frequency] += 1
end

puts "Part Two - The first frequency the device reaches twice is #{current_frequency}"
