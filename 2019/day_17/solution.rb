DATA = File.readlines("./2019/day_17/input.txt")
require_relative "../day_13/intcode_computer"
LARGE_MEMORY = true
require 'pry'

# Part One

def intcode_computer_outputs(codes: CODES.dup, base: 0, index: 0, input: 0, output: [])
  result = intcode_computer(codes: codes, base: base, index: index, input: input, output: output)
  until result.is_a?(Array)
    result = intcode_computer(result)
  end
  result
end

def print_screen(board)
  board.each { |line| puts line }
end

def intersection?(x, y, points)
  [[x, y - 1], [x, y + 1], [x - 1, y], [x + 1, y]].all? do |point|
    points.include?(point)
  end
end

result = intcode_computer_outputs

board = result.map(&:chr).join.split("\n")

hash = {}
board.each_with_index do |line, y|
  line.each_char.with_index do |char, x|
    hash[[x, y]] = char
  end
end

scaffold_points = hash.select { |_, char| char == '#' }.keys

intersections = scaffold_points.select { |x, y| intersection?(x, y, scaffold_points) }

# print_screen(board)

answer1 = intersections.sum { |x, y| x.abs * y.abs }

puts "Part One - The puzzle answer is #{answer1}"

# Part Two

codes = CODES.dup
codes[0] = 2

result = intcode_computer_outputs(codes: codes, input: '')

answer2 = nil

puts "Part Two - The puzzle answer is #{answer2}"

'L,12,L,12,L,7,L,6,R,9,R,4,L,12,L,12,L,12,L,6,L,6,L,12,L,6,R,12,R,8,R,8,R,4,L,12,L,12,L,12,L,6,L,6,L,12,L,6,R,12,R,8,R,8,R,4,L,12,L,12,L,12,L,6,L,6,L,12,L,6,R,12,R,8'
