DATA = File.readlines("./2019/day_24/input.txt")
INITIAL = DATA.each_with_index.with_object({}) do |(line, y), hash|
  line.delete("\n").each_char.with_index do |char, x|
    hash[[x, y]] = char
  end
end

# Part One

def next_tile(grids, position, tile)
  x, y = position
  positions = [[x, y - 1], [x, y + 1], [x - 1, y], [x + 1, y]]
  bugs_count = positions.count { |position| grids[position] == '#' }

  if tile == '#'
    return '.' if bugs_count != 1
  else
    return '#' if [1, 2].include?(bugs_count)
  end
  tile
end

def state_after_one_minute(grids)
  grids.each_with_object({}) do |(position, tile), new_grids|
    new_grids[position] = next_tile(grids, position, tile)
  end
end

def print_state(grids)
  board = Array.new(5) { Array.new(5) }

  grids.each do |(x, y), tile|
    board[y][x] = tile
  end

  board.each { |line| puts line.join }
end

states = Hash.new(0)
current_state = INITIAL
states[current_state] += 1

until states[current_state] == 2
  current_state = state_after_one_minute(current_state)
  states[current_state] += 1
end
# print_state(current_state)

answer1 = current_state.values.each_with_index.sum { |tile, i| tile == '#' ? 2**i : 0 }

puts "Part One - The puzzle answer is #{answer1}"

# Part Two

answer2 = nil

puts "Part Two - The puzzle answer is #{answer2}"
