DATA = File.readlines("./2019/day_06/input.txt")

# Part One

class Star
  attr_accessor :upper, :name

  def initialize(upper, name)
    @upper = upper
    @name = name
  end

  def count_to(upper_name = nil)
    return 0 if name == upper_name || upper.nil?
    1 + upper.count_to(upper_name)
  end

  def uppers
    return [] unless upper
    [upper] + upper.uppers
  end
end

tree = []
find_star = ->(name) { tree.find { |star| star.name == name } }
objects = DATA.map { |code| code.delete("\n").split(")") }

objects.each do |upper_name, name|
  uppper = find_star.call(upper_name)
  unless uppper
    uppper = Star.new(nil, upper_name)
    tree << uppper
  end

  star = find_star.call(name)
  star.upper = uppper if star && star.upper.nil?
  unless star
    star = Star.new(uppper, name)
    tree << star
  end
end

answer1 = tree.sum(&:count_to)

puts "Part One - The puzzle answer is #{answer1}"

# Part Two

you = find_star.call("YOU")
san = find_star.call("SAN")

nearest_same_upper = (you.uppers.map(&:name) & san.uppers.map(&:name)).first

answer2 = you.count_to(nearest_same_upper) + san.count_to(nearest_same_upper) - 2

puts "Part Two - The puzzle answer is #{answer2}"
