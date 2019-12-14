DATA = File.readlines("./2019/day_09/input.txt")
require_relative "../day_13/intcode_computer"
LARGE_MEMORY = true

# Part One

def intcode_computer_outputs(codes: CODES.dup, base: 0, index: 0, input: 1, output: [])
  result = intcode_computer(codes: codes, base: base, index: index, input: input, output: output)
  until result.is_a?(Array)
    result = intcode_computer(result)
  end
  result[0]
end

answer1 = intcode_computer_outputs(input: 1)

puts "Part One - The puzzle answer is #{answer1}"

# Part Two

answer2 = intcode_computer_outputs(input: 2)

puts "Part Two - The puzzle answer is #{answer2}"
