DATA = File.readlines("./2019/day_13/input.txt")
require_relative "intcode_computer"

# Part One

def intcode_computer_outputs(codes: CODES.dup, base: 0, index: 0, input: 0, output: [])
  result = intcode_computer(codes: codes, base: base, index: index, input: input, output: output)
  screen = {}
  until result.is_a?(Array)
    if result[:output].size == 3
      screen = draw(screen, result[:output])
      # sleep 0.04
      # print_screen(screen)
      result = intcode_computer(result.merge(input: move_paddle_value(screen), output: []))
    else
      result = intcode_computer(result)
    end
  end
  screen
end

def draw(screen, instructions)
  position = instructions[0..1]

  if position == [-1, 0]
    screen[:score] = instructions[-1]
    return screen
  end

  case instructions[-1]
  when 0
    screen[position] = '.'
  when 1
    screen[position] = '1'
  when 2
    screen[position] = '2'
  when 3
    screen[position] = '3'
    screen[screen[:paddle_position]] = '.'
    screen[:paddle_position] = position
  when 4
    screen[position] = '4'
    screen[screen[:ball_position]] = '.'
    screen[:ball_position] = position
  end
  screen
end

def move_paddle_value(screen)
  if screen[:paddle_position][0] > screen[:ball_position][0]
    -1
  elsif screen[:paddle_position][0] < screen[:ball_position][0]
    1
  else
    0
  end
rescue
  0
end

def print_screen(screen)
  board = Array.new(25) { Array.new(45, '.') }

  screen.select { |key, _| key&.size == 2 }.each do |(x, y), tile|
    board[y + 1][x + 1] = tile
  end

  board.each { |line| puts line.join }
end

screen = intcode_computer_outputs

answer1 = screen.count { |position, tile| tile == '2' }

puts "Part One - The puzzle answer is #{answer1}"

# Part Two

codes = CODES.dup
codes[0] = 2

screen = intcode_computer_outputs(codes: codes)

answer2 = screen[:score]

puts "Part Two - The puzzle answer is #{answer2}"
