require "pry"

instructions = File.readlines("./input.txt")

def parse(instruction)
  instruction = instruction.chomp
  [instruction[5], instruction[-12]]
end

def left(instructions)
  instructions.map(&:first).uniq.sort
end

def right(instructions)
  instructions.map(&:last).uniq.sort
end

def next_step(instructions)
  (left(instructions) - right(instructions)).first
end

def remain(instructions, step)
  instructions.select { |instruction| instruction[0] != step }
end

def order(instructions)
  last_step = (right(instructions) - left(instructions)).first
  the_order = ''

  until instructions.empty?
    next_step = next_step(instructions)
    the_order << next_step
    instructions = remain(instructions, next_step)
  end

  the_order << last_step
end

# Part One

the_order = order(instructions.map(&method(:parse)))

puts "Part 1: - The order the steps in instructions should be completed is #{the_order}"

# Part Two

the_time = 0

puts "Part 2: - With 5 workers and the 60+ second step durations, the time it take to complete all of the steps is #{the_time}"
