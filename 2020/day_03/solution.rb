input = File.readlines("./2020/day_03/input.txt")

AREA = input.map { |line| line.delete("\n") }
HEIGHT = AREA.size
WIDTH = AREA.first.size

def points(slope)
  right, down = slope
  vertical_size = down == 1 ? HEIGHT - 1 : HEIGHT / down

  (0..vertical_size).to_a.map do |index|
    [index * right, index * down]
  end
end

def encounter_trees_count(slope)
  points(slope).count do |x, y|
    line = AREA[y]
    point = line[x % WIDTH]
    # puts [line, point, x, y].join(' --- ')
    point == '#'
  end
end

def get_result(slopes)
  slopes.map(&method(:encounter_trees_count))
        .inject(:*)
end

# Part One

result = get_result([[3, 1]])

puts "Part One - The puzzle answer is #{result}"

# Part Two

slopes = [
  [1, 1],
  [3, 1],
  [5, 1],
  [7, 1],
  [1, 2]
]

result = get_result(slopes)

puts "Part Two - The puzzle answer is #{result}"
