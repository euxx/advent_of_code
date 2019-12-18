DATA = File.readlines("./2019/day_17/input.txt")
require_relative "../day_13/intcode_computer"

def intcode_computer_outputs(codes: CODES.dup, base: 0, index: 0, input: [], output: [])
  result = intcode_computer(codes: codes, base: base, index: index, input: input, output: output)
  until result.is_a?(Array)
    result = intcode_computer(result)
    # print_screen(screen(result[:output]))
  end
  result
end

def print_screen(screen)
  screen.each { |line| puts line }
end

def screen(codes)
  codes.map(&:chr).join.split("\n")
end

# Part One

def intersection?(x, y, points)
  [[x, y - 1], [x, y + 1], [x - 1, y], [x + 1, y]].all? do |point|
    points.include?(point)
  end
end

screen = screen(intcode_computer_outputs)
# print_screen(screen)

points = {}
screen.each_with_index do |line, y|
  line.each_char.with_index do |char, x|
    points[[x, y]] = char
  end
end

scaffold_points = points.select { |_, char| char == '#' }.keys
intersections = scaffold_points.select { |x, y| intersection?(x, y, scaffold_points) }

answer1 = intersections.sum { |x, y| x.abs * y.abs }

puts "Part One - The puzzle answer is #{answer1}"

# Part Two

# Path => L,12,L,12,L,6,L,6,
# R,8,R,4,L,12, L,12,L,12,L,6,L,6, L,12,L,6,R,12,R,8,
# R,8,R,4,L,12, L,12,L,12,L,6,L,6, L,12,L,6,R,12,R,8,
# R,8,R,4,L,12, L,12,L,12,L,6,L,6, L,12,L,6,R,12,R,8

raw_input = [
  %w[A , B , A , C , B , A , C , B , A , C],
  %w[L , 6 , 6 , L , 6 , 6 , L , 6 , L , 6],
  %w[R , 8 , R , 4 , L , 6 , 6],
  %w[L , 6 , 6 , L , 6 , R , 6 , 6 , R , 8],
  %w[n]
]

input = raw_input.flat_map { |line| line.map(&:ord) + [10] }
codes = CODES.dup
codes[0] = 2

result = intcode_computer_outputs(codes: codes, input: input)

answer2 = result[-1]

puts "Part Two - The puzzle answer is #{answer2}"
