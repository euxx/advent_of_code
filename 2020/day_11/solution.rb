require 'active_support/all'

input = File.readlines("./2020/day_11/input.txt")

initial_grid = input.map { |line| line.delete("\n") }

Y_SIZE = initial_grid.size

# Part One

def seats_adjacent_count(grid, x, y)
  [
    [x - 1, y - 1], [x, y - 1], [x + 1, y - 1],
    [x - 1, y], [x + 1, y],
    [x - 1, y + 1], [x, y + 1], [x + 1, y + 1]
  ].count do |x1, y1|
    next false if x1 < 0 || y1 < 0 || y1 == Y_SIZE

    grid[y1][x1] == '#'
  end
end

def round_result(current_grid)
  next_grid = current_grid.deep_dup

  current_grid.each_with_index do |line, y|
    line.chars.each_with_index do |seat, x|
      count = seats_adjacent_count(current_grid, x, y)
      if seat == 'L'
        next_grid[y][x] = '#' if count.zero?
      elsif seat == '#'
        next_grid[y][x] = 'L' if count >= 4
      end
    end
  end

  next_grid
end

current_grid = initial_grid
last_grid = []

until current_grid == last_grid
  last_grid = current_grid
  current_grid = round_result(current_grid.deep_dup)
end

result = current_grid.flatten.join.count('#')

puts "Part One - The puzzle answer is #{result}"

# Part Two

result =

puts "Part Two - The puzzle answer is #{result}"
