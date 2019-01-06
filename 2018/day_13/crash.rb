require "pry"

raw_map = File.readlines("./test_input.txt")

def next_intersection_direction(car, map)

end

map = []
raw_map.each_with_index do |row, index|
  row.strip.each_char.with_index do |char, idx|
    map << {
      x: index,
      y: idx,
      char: char
    }
  end
end

def parse(square, map)
  x = square[:x]
  y = square[:y]
  x - 1, y
  x + 1, y
  x, y - 1
  x, y + 1

  char = square[:char]
  case char
  when '/'
    x - 1, y
    x + 1, y
    x, y - 1
    x, y + 1
  when '\\'
    x - 1, y
    x + 1, y
    x, y - 1
    x, y + 1
  when '-'
    x - 1, y
    x + 1, y
  when '|'
    x, y - 1
    x, y + 1
  when '+'
  when '<'
    x - 1, y
    x + 1, y
    x, y - 1
    x, y + 1
  when '>'
    x - 1, y
    x + 1, y
    x, y - 1
    x, y + 1
  end
end

def move

end

car = {
  x: 0,
  y: 0,
  next_direction: nil,
  next_intersection_direction: 'left',
}
binding.pry
# Part One

the_location = nil

puts "Part 1: - The location of the first crash is #{the_location}"

# Part Two


# puts "Part 2: - The is #{}"
