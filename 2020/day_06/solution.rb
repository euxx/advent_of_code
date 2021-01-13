input = File.read("./2020/day_06/input.txt")

questions = input.split("\n\n").map(&:split)

# Part One

result = questions.sum { |lines| lines.join.chars.uniq.size }

puts "Part One - The puzzle answer is #{result}"

# Part Two

result = questions.sum { |lines| lines.map(&:chars).reduce(:&).size }

puts "Part Two - The puzzle answer is #{result}"
