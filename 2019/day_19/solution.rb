DATA = File.readlines("./2019/day_19/input.txt")
require_relative "../day_13/intcode_computer"

def intcode_computer_outputs(codes: CODES.dup, base: 0, index: 0, input:, output: [])
  result = intcode_computer(codes: codes, base: base, index: index, input: input, output: output)
  until result.is_a?(Array)
    result = intcode_computer(result)
  end
  result
end

def print_screen(points, size)
  board = Array.new(size) { Array.new(size, '.') }

  points.each do |(x, y)|
    board[y][x] = '#'
  end

  board.each { |line| puts line.join }
end

def affected?(point)
  intcode_computer_outputs(input: point.dup)[0] == 1
end

# Part One

def affected_points(size)
  numbers = (0...size).to_a
  points = numbers.product(numbers)

  points.select(&method(:affected?))
end

result = affected_points(50)
# print_screen(result, 50)

answer1 = result.size

puts "Part One - The puzzle answer is #{answer1}"

# Part Two

def line_points(n)
  ((n/2)..n).to_a.map { |i| [i, n] }
end

def affected_first_point(n)
  line_points(n).find(&method(:affected?))
end

def affected_line_points(n)
  line_points(n).select(&method(:affected?))
end

def the_point?(top_left, n, size)
  x, y = top_left
  calculated_bottom_left = [x, y + size - 1]
  actual_bottom_left = affected_first_point(n + size - 1)
  calculated_bottom_left[0] >= actual_bottom_left[0]
end

def top_left(n, size)
  affected_line_points(n)[-size]
end

size = 100
n = 1240
top_left = top_left(n, size)

until the_point?(top_left, n, size)
  puts n
  top_left = top_left(n, size)
  n += 1
end

x, y = point

answer2 = x * 10000 + y

puts "Part Two - The puzzle answer is #{answer2}"
