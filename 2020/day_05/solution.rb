input = File.readlines("./2020/day_05/input.txt")

passes = input.map { |line| line.delete("\n") }

# Part One

def range_or_result(range, direction, is_last)
  min, max = range
  middle = range.sum / 2

  if %w[F L].include?(direction)
    is_last ? middle : [min, middle]
  else
    is_last ? middle + 1 : [middle + 1, max]
  end
end

def seat_position(pass)
  pass = pass.chars

  row = pass[0..6].each_with_index.reduce([0, 127]) do |range, (direction, index)|
    range_or_result(range, direction, index == 6)
  end

  column = pass[-3..-1].each_with_index.reduce([0, 7]) do |range, (direction, index)|
    range_or_result(range, direction, index == 2)
  end

  [row, column]
end

seat_positions = passes.map(&method(:seat_position))

result = seat_positions.map { |row, column| row * 8 + column }.max

puts "Part One - The puzzle answer is #{result}"

# Part Two

target_seat_positions =
  seat_positions.group_by(&:first)
                .select { |_row, seat_positions| seat_positions.size == 7 }

row =  target_seat_positions.keys.first
column = ((1..7).to_a - target_seat_positions[row].map(&:last)).first

result = row * 8 + column

puts "Part Two - The puzzle answer is #{result}"
