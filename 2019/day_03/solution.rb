DATA = File.readlines("./2019/day_03/input.txt")

# Part One

def parse(code)
  [code[0], code[1..-1].to_i]
end

def path(wire, x = 0, y = 0)
  wire.split(',').each_with_object([]) do |code, path|
    direction, distance = parse(code)
    case direction
    when 'U'
      y.upto(y + distance - 1) { |i| path << [x, i] }
      y += distance
    when 'D'
      y.downto(y - distance + 1) { |i| path << [x, i] }
      y -= distance
    when 'L'
      x.downto(x - distance + 1) { |i| path << [i, y] }
      x -= distance
    when 'R'
      x.upto(x + distance - 1) { |i| path << [i, y] }
      x += distance
    end
  end
end

path1 = path(DATA.first)
path2 = path(DATA.last)

crosses = (path1 & path2)[1..-1]
distances = crosses.map { |x, y| x.abs + y.abs }

answer1 = distances.min

puts "Part One - The puzzle answer is #{answer1}"

# Part Two


steps = crosses.map { |point| path1.index(point) + path2.index(point) }

answer2 = steps.min

puts "Part Two - The puzzle answer is #{answer2}"
