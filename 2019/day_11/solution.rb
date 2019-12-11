DATA = File.readlines("./2019/day_11/input.txt")
CODES = DATA.first.split(',').map(&:to_i)
CODES_SIZE = CODES.size

# Part One

def index_at(index, mode, base, codes)
  case mode
  when 1
    index
  when 2
    codes[index % CODES_SIZE] + base
  else
    codes[index % CODES_SIZE]
  end
end

def update_index(index, opcode)
  if [1, 2, 7, 8].include?(opcode)
    index + 4
  elsif [3, 4, 9].include?(opcode)
    index + 2
  else
    index
  end
end

def intcode_computer(codes:, base:, index:, input:, output:)
  code = codes[index].digits
  opcode = code[1].to_i * 10 + code[0]
  return if opcode == 99

  index1 = index_at(index + 1, code[2], base, codes) % CODES_SIZE
  index2 = index_at(index + 2, code[3], base, codes) % CODES_SIZE
  index3 = index_at(index + 3, code[4], base, codes) % CODES_SIZE
  value1 = codes[index1]
  value2 = codes[index2]

  case opcode
  when 1
    codes[index3] = value1 + value2 rescue binding.pry
  when 2
    codes[index3] = value1 * value2 rescue binding.pry
  when 3
    codes[index1] = input
  when 4
    output << value1
  when 5
    value1 != 0 ? index = value2 : index += 3
  when 6
    value1 == 0 ? index = value2 : index += 3
  when 7
    codes[index3] = value1 < value2 ? 1 : 0
  when 8
    codes[index3] = value1 == value2 ? 1 : 0
  when 9
    base += value1
  end

  {codes: codes, base: base, index: update_index(index, opcode), input: input, output: output}
end

def panels(codes: CODES.dup, base: 0, index: 0, input:, output: [])
  panels = Hash.new(input == 0 ? '.' : '#')
  robot = {position: [0, 0], direction: '^'}
  result = intcode_computer(codes: codes, base: base, index: index, input: input, output: output)

  until result.nil?
    if result[:output].size == 2
      color_code, turn_code = result[:output]
      panels, robot = move(panels, robot, color_code, turn_code)
      color_code = panels[robot[:position]] == '.' ? 0 : 1
      result = intcode_computer(result.merge(input: color_code, output: []))
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
