DATA = File.readlines("./2019/day_10/input.txt")

# Part One

def parse(line, y)
  line.delete("\n").split('')
      .map.with_index { |char, x| char == '#' ? [x, y] : nil }
      .compact
end

STARS = DATA.each_with_index.reduce([]) do |stars, (line, y)|
  stars + parse(line, y)
end

def detected_stars_count(star)
  x1, y1 = star
  (STARS - [star]).group_by { |x2, y2| Math.atan2(x1 - x2, y1 - y2) }.count
end

answer1 = STARS.map(&method(:detected_stars_count)).max

puts "Part One - The puzzle answer is #{answer1}"

# Part Two

answer2 = nil

puts "Part Two - The puzzle answer is #{answer2}"
