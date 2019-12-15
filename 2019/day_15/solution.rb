DATA = File.readlines("./2019/day_15/input.txt")
require_relative "../day_13/intcode_computer"
require "pry"
# Part One

def intcode_computer_outputs(codes: CODES.dup, base: 0, index: 0, input: 1, output: [])
  result = intcode_computer(codes: codes, base: base, index: index, input: input, output: output)
  data = { area: {}, droid: { current_position: [0, 0], move: input } }

  until result.is_a?(Array) || result[:output][0] == 2
    data = handle(data, result[:output][0])
    result = intcode_computer(result.merge(input: data[:droid][:move], output: []))
  end

  binding.pry
  data
end

def handle(data, status)
  current_position = data[:droid][:current_position]
  x, y = current_position
  moves = [1, 2, 3, 4]
  case status
  when 0
    case data[:droid][:move]
    when 1
      y += 1
      moves.delete(1)
    when 2
      y -= 1
      moves.delete(2)
    when 3
      x -= 1
      moves.delete(3)
    when 4
      x += 1
      moves.delete(4)
    end

    data[:area][[x, y]] = '#'
  when 1
    data[:area][current_position] ||= '.'
  end

  move = moves.find { |move| data[:area][calc_position(move, x, y)].nil? } ||
         moves.find { |move| data[:area][calc_position(move, x, y)] == '.' }

  data[:droid][:move] = move
  data
end

def calc_position(move, x, y)
  case move
  when 1
    y += 1
  when 2
    y -= 1
  when 3
    x -= 1
  when 4
    x += 1
  end

  [x, y]
end

def print_area(area)
  board = Array.new(25) { Array.new(45, ' ') }

  area.each do |(x, y), tile|
    board[y + 1][x + 1] = tile
  end

  board.each { |line| puts line.join }
end

data = intcode_computer_outputs

answer1 = data

puts "Part One - The puzzle answer is #{answer1}"

print_area(data[:area])

# Part Two

answer2 = nil

puts "Part Two - The puzzle answer is #{answer2}"
