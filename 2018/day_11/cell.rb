require "pry"

SERIAL_NUMBER = 1133
SIDE_LENGTH = 300

def power(cell)
  x, y = cell
  id = x + 10
  power = (id * y + SERIAL_NUMBER) * id
  power.to_s[-3].to_i - 5
end

def total_power(square)
  square.sum(&method(:power))
end

def square(x, y, size)
  axis_points(x, size).product(axis_points(y, size))
end

def axis_points(n, size)
  (n..(n + size)).to_a
end

def squares(size)
  max_space = (1..SIDE_LENGTH - size).to_a
  max_space.product(max_space)
end

def largest_power(size)
  squares(size - 1).map { |x, y|
    [[x, y, size],total_power(square(x, y, size - 1))]
  }.max_by(&:last)
end

def largest_power_of_all
  power = 1
  size = 1
  powers = []
  while power > 0
    group = largest_power(size)
    powers << group
    power = group.last
    size += 1
    puts group.join(', ')
  end
  powers.max_by(&:last)
end

def sum_power(x, y)
  power([x, y]) + TABLE["#{x-1},#{y}"] + TABLE["#{x},#{y-1}"] - TABLE["#{x-1},#{y-1}"]
end

TABLE = Hash.new(0)
T = {}
axis_points = (1..SIDE_LENGTH).to_a


axis_points.product(axis_points).each do |x, y|
  T["#{x},#{y}"]  = power([x, y])# if x < 4 && y < 4
  TABLE["#{x},#{y}"] = sum_power(x, y)# if   x < 4 && y < 4
end

# 0 2  3
# 2 3  -5
# 3 -5 -3
#
# 0 2 5
# 2 7 5
# 5 5 0

def fast_total_power(x, y, size)
  a = [x, y]
  b = [x + size, y]
  c = [x + size, y + size]
  d = [x, y + size]
  TABLE[key(a)] + TABLE[key(c)] - TABLE[key(b)] - TABLE[key(d)]
end

def key(coordinate)
  coordinate.join(',')
end

def fast_largest_power(size)
  squares(size - 1).map { |x, y|
    [[x, y, size], fast_total_power(x, y, size - 1)]
  }.max_by(&:last)
end

# binding.pry
# Part One

the_coordinate = largest_power(3)

puts "Part 1: - The X,Y coordinate of the top-left fuel cell of the 3x3 square with the largest total power is #{the_coordinate}"

# Part Two

# the_coordinate_and_size = largest_power_of_all
the_coordinate_and_size = fast_largest_power(3)

puts "Part 2: - The the X,Y,size identifier of the square with the largest total power is #{the_coordinate_and_size}"
