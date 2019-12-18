DATA = File.readlines("./2019/day_11/input.txt")
require_relative "../day_13/intcode_computer"

# Part One

def panels(codes: CODES.dup, base: 0, index: 0, input:, output: [])
  panels = Hash.new(input == 0 ? '.' : '#')
  robot = {position: [0, 0], direction: '^'}
  result = intcode_computer(codes: codes, base: base, index: index, input: [input], output: output)

  until result.is_a?(Array)
    if result[:output].size == 2
      color_code, turn_code = result[:output]
      panels, robot = move(panels, robot, color_code, turn_code)
      color_code = panels[robot[:position]] == '.' ? 0 : 1
      result = intcode_computer(result.merge(input: [color_code], output: []))
    else
      result = intcode_computer(result)
    end
  end

  panels
end

def direction(direction, turn_code)
  case direction
  when '^'
    turn_code == 0 ? '<' : '>'
  when 'v'
    turn_code == 0 ? '>' : '<'
  when '<'
    turn_code == 0 ? 'v' : '^'
  when '>'
    turn_code == 0 ? '^' : 'v'
  end
end

def move(panels, robot, color_code, turn_code)
  x, y = robot[:position]
  panels[[x, y]] = color_code == 0 ? '.' : '#'

  current_direction = direction(robot[:direction], turn_code)
  case current_direction
  when '^'
    y += 1
  when 'v'
    y -= 1
  when '<'
    x -= 1
  when '>'
    x += 1
  end

  [panels, {position: [x, y], direction: current_direction }]
end

answer1 = panels(input: 0).size

puts "Part One - The puzzle answer is #{answer1}"

# Part Two

panels = panels(input: 1)

puts "Part Two - The puzzle answer is"

board = Array.new(8) { Array.new(42, '.') }

panels.each do |(x, y), color|
  board[y + 6][x] = color
end

board.reverse.each do |line|
  puts line.map { |digit| digit == '#' ? "\u2591\u2591" : '  ' }.join
end
