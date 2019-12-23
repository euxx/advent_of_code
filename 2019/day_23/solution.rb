DATA = File.readlines("./2019/day_23/input.txt")
require_relative "../day_13/intcode_computer"
require "pry"

def intcode_computer_outputs(codes: CODES.dup, base: 0, index: 0, input:, output: [])
  result = intcode_computer(codes: codes, base: base, index: index, input: input, output: output)
  until result.is_a?(Array) || result[:output].size == 3 ||
    result = intcode_computer(result.merge(input: [-1]))
  end
  result
end

# Part One

computers = (0..49).map do |index|
  intcode_computer_outputs(input: [index])
end

address = nil
queues = []
result = nil
count = 0
until address == 255
  count += 1
  # print '.'
  computers.each_with_index do |computer, index|
    input = -> {
      queue = queues.find { |address, _, _| address == index }
      queues.slice!(queues.index(queue)) if queue
      queue && queue[1..2] rescue binding.pry
    }

    output = computer[:output]
    if output.size == 3
      queues << output
      if output[0] > 50
        binding.pry
        address = 255
        result = output
      end
      output = []
    end

    input = if computer[:input].empty?
      input.call || [-1]
    else
      computer[:input]
    end
    computers[index] = intcode_computer_outputs(computer.merge(input: input, output: output))

    if count >= 100000# && index == 49
      p queues
      binding.pry
    end
  end
end
binding.pry

answer1 = nil

puts "Part One - The puzzle answer is #{answer1}"

# Part Two

answer2 = nil

puts "Part Two - The puzzle answer is #{answer2}"
