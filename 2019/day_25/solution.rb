DATA = File.readlines("./2019/day_25/input.txt")
require_relative "../day_13/intcode_computer"

def intcode_computer_outputs(codes: CODES.dup, base: 0, index: 0, input: [], output: [])
  result = intcode_computer(codes: codes, base: base, index: index, input: input, output: output)
  until result.is_a?(Array)
    screen = parse_screen(result[:output])
    if screen[-1] == 'Command?' && result[:input].empty?
      print_screen(screen)
      input = encode(gets.chomp)
    end
    result = intcode_computer(result.merge(input: input))
  end
  result
end

def print_screen(screen)
  screen.each { |line| puts line }
end

def parse_screen(codes)
  codes.map(&:chr).join.split("\n")
end

def encode(instruction)
  "#{instruction}\n\n".chars.map(&:ord)
end

# Part One

# collect: coin, hypercube, tambourine, dark matter

screen = parse_screen(intcode_computer_outputs)

puts "Part One - The puzzle answer is"

print_screen(screen)
