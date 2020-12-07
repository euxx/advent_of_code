input = File.readlines("./2020/day_06/input.txt")

questions = input.join
                 .split("\n\n")
                 .map { |line| line.tr("\n", ' ').split(' ') }

# Part One

result = questions.sum { |lines| lines.join.chars.uniq.size }

puts "Part One - The puzzle answer is #{result}"

# Part Two

result = questions.sum { |lines| lines.map(&:chars).reduce(:&).size }

puts "Part Two - The puzzle answer is #{result}"
