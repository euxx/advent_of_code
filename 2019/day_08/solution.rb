DATA = File.readlines("./2019/day_08/input.txt")
WIDTH = 25
HEIGHT = 6
SIZE = WIDTH * HEIGHT
LAYERS = DATA.first.split('').each_slice(SIZE)

# Part One

def number_of_digits(layer, digit)
  SIZE - (layer - [digit]).size
end

the_layer_having_fewest_0 =
  LAYERS.min_by { |layer| number_of_digits(layer, '0') }

the_number_of_1_digits = number_of_digits(the_layer_having_fewest_0, '1')
the_number_of_2_digits = number_of_digits(the_layer_having_fewest_0, '2')

answer1 = the_number_of_1_digits * the_number_of_2_digits

puts "Part One - The puzzle answer is #{answer1}"

# Part Two

the_final_image_digits = (0...SIZE).map do |index|
  LAYERS.find { |layer| %w[0 1].include?(layer[index]) }[index]
end

puts "Part Two - The puzzle answer is"

the_final_image_digits.each_slice(WIDTH) do |line|
  puts line.map { |digit| digit == '1' ? "\u2591\u2591" : '  ' }.join
end
