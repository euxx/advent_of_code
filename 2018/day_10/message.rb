require "pry"

raw_messages = File.readlines("./input.txt")

def parse(raw_message)
  raw_message.split(/position=|.velocity=/)[1..-1].map { |pair|
    pair[1..-2].split(',').map(&:to_i)
  }
end

messages = raw_messages.map(&method(:parse))

# Part One

the_seconds = 0
until messages.flat_map(&:first).max  < 204
  messages = messages.map do |(y, x), (v_y, v_x)|
    [[y+v_y, x+v_x], [v_y, v_x]]
  end
  the_seconds += 1
end

width = 100
offset = 110
grids = Array.new(width) { Array.new(width, '.') }

messages = messages.map do |(y, x), _|
  grids[x-offset][y-offset] = '#'
end

grids.each do |line|
  line.each do |point|
    print point
  end
  puts ''
end

the_message = 'ajznxhke'

puts "Part 1: - The message eventually appear in the sky is #{the_message}"

# Part Two

puts "Part 2: - The seconds needed to wait for that message to appear is #{the_seconds}"
