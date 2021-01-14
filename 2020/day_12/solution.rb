input = File.readlines("./2020/day_12/input.txt")

INSTRUCTIONS = input.map { |line| [line[0], line[1..].to_i] }

DIRS = {
  'N' => Complex(0, 1),
  'S' => Complex(0, -1),
  'E' => Complex(1, 0),
  'W' => Complex(-1, 0),
  'L' => Complex(0, 1),
  'R' => Complex(0, -1),
}

def move_ship(way_poiont, is_part_2: false)
  ship = Complex(0, 0)

  INSTRUCTIONS.each do |action, value|
    case action
    when 'N', 'S', 'E', 'W'
      if is_part_2
        way_poiont += DIRS[action] * value
      else
        ship += DIRS[action] * value
      end
    when 'F'
      ship += way_poiont * value
    when 'L', 'R'
      way_poiont *= DIRS[action] ** (value / 90)
    end
  end

  ship
end

# Part One

direction = DIRS['E']

result = move_ship(direction).rect.sum(&:abs)

puts "Part One - The puzzle answer is #{result}"

# Part Two

way_poiont = 10 * DIRS['E'] + DIRS['N']

result = move_ship(way_poiont, is_part_2: true).rect.sum(&:abs)

puts "Part Two - The puzzle answer is #{result}"
