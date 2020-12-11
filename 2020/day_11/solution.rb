require 'active_support/all'

input = File.readlines("./2020/day_11/input.txt")

initial_grid = input.map { |line| line.delete("\n") }

Y_SIZE = initial_grid.size
X_SIZE = initial_grid.first.size

require "pry"

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
    next false if x1 < 0 || y1 < 0 || y1 == Y_SIZE

    grid[y1][x1] == '#'
  end
end

def round_result(current_grid, seen:, round: 0)
  next_grid = current_grid.deep_dup

  current_grid.each_with_index do |line, y|
    line.chars.each_with_index do |seat, x|
      count = seen ? seats_seen_count(current_grid, x, y, round: round) : seats_adjacent_count(current_grid, x, y)

      # binding.pry if y == 0 && x == 0 && seen

      if seat == 'L'
        next_grid[y][x] = '#' if count.zero?
      elsif seat == '#'
        next_grid[y][x] = 'L' if count >= (seen ? 5 : 4)
      end
    end
  end

  # binding.pry if seen
  next_grid
end


def final_grid(grid, seen: false)
  current_grid = grid.deep_dup
  last_grid = []
  round = 0

  until current_grid == last_grid
    round += 1
    last_grid = current_grid.deep_dup
    current_grid = round_result(current_grid.deep_dup, seen: seen, round: round)
  end

  current_grid
end


result = final_grid(initial_grid).flatten.join.count('#')

puts "Part One - The puzzle answer is #{result}"

# Part Two

def seats_seen_count(grid, x, y, round:)
  seats = (0..X_SIZE-1).to_a.product((0..Y_SIZE-1).to_a)

  a = adjacent_seats(x, y).map { |x1, y1| Math.atan2(x - x1, y - y1) }

  # binding.pry if y == 0 && x == 0

  p1 = (seats - [x, y]).select { |x2, y2| grid[y2][x2] == '#' || grid[y2][x2] == 'L' }

  p2 = p1.group_by { |x1, y1| Math.atan2(x - x1, y - y1) }
         .select { |key, _| a.include?(key) }

  p3 =  p2.map do |_, sub_seats|
      sub_seats.min_by { |x3, y3| (x - x3).abs + (y - y3).abs }
    end

  binding.pry if y == 1 && x == 9 && round == 3
  p3.count { |x4, y4| grid[y4][x4] == '#' }
end

# g1 = round_result(initial_grid.deep_dup, seen: true)
# g2 = round_result(g1.deep_dup, seen: true, round: 2)
# g3 = round_result(g2.deep_dup, seen: true, round: 3)
# # g4 = round_result(g3.deep_dup, seen: true)


final_grid = final_grid(initial_grid.deep_dup, seen: true)
# binding.pry<%=  %>

result = final_grid.flatten.join.count('#')
# binding.pry

# binding.pry

puts "Part Two - The puzzle answer is #{result}"
