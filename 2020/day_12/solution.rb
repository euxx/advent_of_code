input = File.readlines("./2020/day_12/input.txt")

instructions = input.map do |line|
  instruction = line.delete("\n")

  [instruction[0], instruction[1..-1].to_i]
end

# Part One

ship = { direction: 'E', x: 0, y: 0 }

def move(ship, action, value)
  case action
  when 'N'
    ship[:y] += value
  when 'S'
    ship[:y] -= value
  when 'E'
    ship[:x] += value
  when 'W'
    ship[:x] -= value
  end
end

directions = ['N', 'E', 'S', 'W']

instructions.each do |action, value|
  direction = ship[:direction]
  case action
  when 'N', 'S', 'E', 'W'
    move(ship, action, value)
  when 'F'
    move(ship, direction, value)
  when 'L'
    index = -((value / 90) % 4) + directions.index(direction)
    ship[:direction] = directions[index]
  when 'R'
    index = (value / 90 + directions.index(direction)) % 4
    ship[:direction] = directions[index]
  end
end

result = ship[:x].abs + ship[:y].abs

puts "Part One - The puzzle answer is #{result}"

# Part Two

ship = { x: 0, y: 0 }
way_point = { x: 10, y: 1 }

def points(point)
  x, y = point[0], point[1]

  [
    [x, y],
    [y, -x],
    [-x, -y],
    [-y, x],
  ]
end

instructions.each do |action, value|
  case action
  when 'N', 'S', 'E', 'W'
    move(way_point, action, value)
  when 'F'
    move(ship, 'E', way_point[:x] * value)
    move(ship, 'N', way_point[:y] * value)
  when 'L', 'R'
    point = [way_point[:x], way_point[:y]]
    points = points(point)
    index =
      if action == 'L'
        -((value / 90) % 4) + points.index(point)
      else
        (value / 90 + points.index(point)) % 4
      end
    x, y = points[index]
    way_point = { x: x, y: y }
  end
end

result = ship[:x].abs + ship[:y].abs

puts "Part Two - The puzzle answer is #{result}"
