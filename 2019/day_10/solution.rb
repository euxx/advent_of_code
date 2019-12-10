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

def block?(star, another_star, any_star)
  x1, y1 = star
  x2, y2 = any_star
  x3, y3 = another_star

  (x2 - x1) * (y3 - y1) == (x3 - x1) * (y2 - y1) &&
  ((x1 - x2) * (x2 - x3) > 0 || (y1 - y2) * (y2 - y3) > 0)
end

def detected?(star, another_star, remain_stars)
  !remain_stars.any? { |any_star| block?(star, another_star, any_star) }
end

def detected_stars_count(star)
  other_stars = STARS - [star]
  other_stars.count do |another_star|
    detected?(star, another_star, other_stars - [another_star])
  end
end

answer1 = STARS.map(&method(:detected_stars_count)).max

puts "Part One - The puzzle answer is #{answer1}"

# Part Two

answer2 = nil

puts "Part Two - The puzzle answer is #{answer2}"
