input = File.readlines("./2020/day_08/input.txt")

INSTRUCTIONS = input.map do |line|
  operation, argument = line.strip.split(' ')
  [operation, argument.to_i]
end
SIZE = INSTRUCTIONS.size

# Part One

def program(instructions)
  accumulator = 0
  index = 0
  executed = Hash.new(0)
  terminated = false

  until executed[index] == 1 || terminated
    operation, argument = instructions[index]
    executed[index] += 1
    terminated = true if index == SIZE - 1

    case operation
    when 'acc'
      index += 1
      accumulator += argument
    when 'jmp'
      index += argument
    when 'nop'
      index += 1
    end
  end

  {accumulator: accumulator, terminated: terminated}
end

result = program(INSTRUCTIONS)[:accumulator]

puts "Part One - The puzzle answer is #{result}"

# Part Two

result = nil

INSTRUCTIONS.each_with_index do |instruction, index|
  operation, argument = instruction
  next if operation == 'acc'

  instructions = INSTRUCTIONS.clone
  instructions[index] = [{'jmp' => 'nop', 'nop' => 'jmp'}[operation], argument]

  result = program(instructions)
  break result = result[:accumulator] if result[:terminated]
end

puts "Part Two - The puzzle answer is #{result}"
