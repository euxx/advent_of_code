require 'active_support/all'

input = File.readlines("./2020/day_11/input.txt")

initial_grid = input.map { |line| line.delete("\n") }

HEIGHT = initial_grid.size
WIDTH = initial_grid.first.size

def in_grid?(x, y)
  y.between?(0, HEIGHT-1) && x.between?(0, WIDTH-1)
end

def next_grid(current_grid, seen:)
  next_grid = current_grid.deep_dup

  current_grid.each_with_index do |line, y|
    line.chars.each_with_index do |seat, x|
      count = seen ? seats_seen_count(current_grid, x, y) : seats_adjacent_count(current_grid, x, y)

      if seat == 'L' && count.zero?
        next_grid[y][x] = '#'
      elsif seat == '#' && count >= (seen ? 5 : 4)
        next_grid[y][x] = 'L'
      end
    end
  end

  next_grid
end

def final_grid(grid, seen: false)
  current_grid = grid
  last_grid = []

  until current_grid == last_grid
    last_grid = current_grid
    current_grid = next_grid(current_grid.deep_dup, seen: seen)
  end

  current_grid
end

def occupied_count(grid)
  grid.join.count('#')
end

# Part One

def adjacent_seats(x, y)
  [
    [x - 1, y - 1], [x, y - 1], [x + 1, y - 1],
    [x - 1, y], [x + 1, y],
    [x - 1, y + 1], [x, y + 1], [x + 1, y + 1]
  ]
end

def seats_adjacent_count(grid, x, y)
  adjacent_seats(x, y).count do |x1, y1|
    in_grid?(x1, y1) && grid[y1][x1] == '#'
  end
end

final_grid = final_grid(initial_grid)

result = occupied_count(final_grid)

puts "Part One - The puzzle answer is #{result}"

# Part Two

MOVES = adjacent_seats(0, 0)

def seats_seen_count(grid, x, y, count: 0)
  MOVES.each do |move_x, move_y|
    current_y = y + move_y
    current_x = x + move_x
    loop do
      break unless in_grid?(current_x, current_y)

      seat = grid[current_y][current_x]
      count += 1 if seat == '#'
      break if seat == '#' || seat == 'L'

      current_y += move_y
      current_x += move_x
    end
  end

  count
end

final_grid = final_grid(initial_grid, seen: true)

result = occupied_count(final_grid)

puts "Part Two - The puzzle answer is #{result}"
