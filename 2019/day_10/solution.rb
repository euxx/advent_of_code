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

def detected_stars(star)
  x1, y1 = star
  (STARS - [star]).group_by { |x2, y2| Math.atan2(x1 - x2, y1 - y2) }
    .map { |_, stars| stars.min_by { |x3, y3| (x1 - x3).abs + (y1 - y3).abs } }
end

best_location = STARS.max_by { |star| detected_stars(star).size }
max_detected_stars = detected_stars(best_location)

answer1 = max_detected_stars.size

puts "Part One - The puzzle answer is #{answer1}"

# Part Two

NTH = 200

x0, y0 = best_location
sorted_stars = max_detected_stars.sort_by do |x, y|
  theta = Math.atan2(x - x0, y0 - y) * 180 / Math::PI
  theta < 0 ? theta + 360 : theta
end

x, y = sorted_stars[NTH - 1]

answer2 = x * 100 + y

puts "Part Two - The puzzle answer is #{answer2}"
