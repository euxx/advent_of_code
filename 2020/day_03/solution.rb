input = File.readlines("./2020/day_03/input.txt")

AREA = input.map(&:strip)
HEIGHT = AREA.size
WIDTH = AREA.first.size

def count_trees(slope)
  right, down = slope

  (0...HEIGHT).step(down).count do |y|
    x = y / down * right % WIDTH

    AREA[y][x] == '#'
  end
end

def get_result(slopes)
  slopes.map(&method(:count_trees))
        .reduce(:*)
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
