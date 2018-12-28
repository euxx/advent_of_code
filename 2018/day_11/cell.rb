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

# Part One

the_coordinate = largest_power(3)

puts "Part 1: - The X,Y coordinate of the top-left fuel cell of the 3x3 square with the largest total power is #{the_coordinate}"

# Part Two

the_coordinate_and_size = largest_power_of_all

puts "Part 2: - The the X,Y,size identifier of the square with the largest total power is #{the_coordinate_and_size}"
