DATA = File.readlines("./2019/day_14/input.txt")
require "pry"

def parse(line)
  left, right = line.delete("\n").split(' => ')
  left = left.split(', ').map { |chars| chars.split(' ') }
  right = right.split(' ')

  {
    left: left,
    right: right
  }
end

all = DATA.map(&method(:parse))

def xishu(all, num, name)
  formula = all.find { |f| f[:right][1] == name }
  right_num = formula[:right][0].to_f
  (num.to_i / right_num).ceil
rescue
  num.to_i
end

def parse_formula(all, name)
  return 1 if name == 'ORE'
  current = all.find { |f| f[:right][1] == name }
  # right_num = current[:right][0]

  current[:left].sum do |num, name|
    xishu(all, num, name)  * parse_formula(all, name)
  end
end

# r = parse_formula(all, 'FUEL')


# fuel = all.find { |f| f[:right][1] == "FUEL" }

# lefts = fuel[:left]
wasted = Hash.new(0)
wasted[:record] = Hash.new(0)

def lefts(all, wasted, name)
  current = all.find { |f| f[:right][1] == name }

  lefts = current[:left] rescue binding.pry

  # lefts.map do |num, name|
  done = nil
  result = []
  done = false
  until done
    lefts.each do |num, name|
      # binding.pry
      if name == "ORE"
        result << [1, [[num.to_i, "ORE"]]]
        next
      end

      lower = all.find { |f| f[:right][1] == name }
      lower_right_num = lower[:right][0].to_i

      num =
        if wasted[name] > num.to_i
          wasted[name] = wasted[name] - num.to_i
          0
        elsif wasted[name] < num.to_i
          temp = num.to_i - wasted[name]
          wasted[name] = 0
          temp
        else
          wasted[name] = 0
          0
        end

      if num == 0
        binding.pry
        next 0
      end

      n =
        if lower_right_num > num
          wasted[name] = lower_right_num - num
          1
        elsif lower_right_num < num
          n = (num / lower_right_num.to_f).ceil
          wasted[name] = n * lower_right_num - num
          n
        else
          1
        end
      # [lower[:left], n, lefts(all, wasted, name)]
      # binding.pry
      # [n, lefts(all, wasted, name)]
      # n * lefts(all, wasted, name)
      [n, lower[:left]]

      result << [n, lower[:left]]
    end

    binding.pry
    lefts = result.reduce([]) do |result, (n, group)|
      group = group.map { |num, name| [num.to_i * n, name] }
      result + group
    end
    result = []
  end
end

# r = lefts.map do |num, name|
#   lower = all.find { |f| f[:right][1] == name }
  # lower_right_num = lower[:right][0].to_i
  # lefts =
  # if lower_right_num > num.to_i
  #   wasted[name] = lower_right_num - num.to_i
  #   lower[:left]
  # elsif lower_right_num < num.to_i
  #
  # else
  #   lower[:left]
  # end
  # lower[:left]
#   lefts(all, wasted, "FUEL")
# end

r = lefts(all, wasted, "FUEL")
binding.pry
puts r
# Part One


answer1 = nil

puts "Part One - The puzzle answer is #{answer1}"

# Part Two


answer2 = nil

puts "Part Two - The puzzle answer is #{answer2}"



class Formula
  attr_accessor :left, :right


  def initialize(left, right)

  end
end

find_ore = false

until find_ore
  find_ore = true
end
