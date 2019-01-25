require "pry"

raw_coordinates = File.readlines("./test_input.txt")

def parse(raw_coordinates)
  raw_coordinates.reduce([]) do |coordinates, c|
    l, r = c.split(', ')
    l = l[2..-1].to_i
    r = Range.new(*r.chomp[2..-1].split('..').map(&:to_i))
    coordinates += c[0] == 'x' ? [l].product(r.to_a) : r.to_a.product([l])
  end
end

def set(x, y, type)
  map[y][x] = type
end

coordinates = parse(raw_coordinates)
min, max = coordinates.map(&:first).minmax
offset = min - 1
width = max - min + 3
length = coordinates.map(&:last).max + 2

map = Array.new(length) { Array.new(width, '.') }
coordinates.each do |x, y|
  map[y][x - offset]= '#'
end

center = (width / 2).to_i - 1
map[0][center] = '+'

map.each do |row|
  row.each do |point|
    print point
  end
  puts
end

# current = { x: center, y: 0, type: '.' }
#
# while current['y'] < length
#
# end

def fall(x, y)
  return if y + 1 > length
  point = map[y + 1][x - offset]
  if point == '.'
    map[y + 1][x - offset] = '|'
    fall(x, y + 1)
  else
    fill_left(x, y)
    fill_right(x, y)
  end
end

def fill_left(x, y)
  point = map[y][x - offset - 1]
  if point == '.'
    if map[y + 1][x - offset - 1] == '#'
      map[y][x - offset - 1] = '|'
      fill_left(x - 1, y)
    elsif map[y + 1][x - offset - 1] == '.'
      map[y][x - offset - 1] = '|'
      fall(x - 1, y)
    end
  end
end
