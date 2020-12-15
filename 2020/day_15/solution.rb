input = '0,3,6'

numbers = input.split(',').map(&:to_i)
size = numbers.size

require "pry"

# Part One

turns = numbers.map.with_index { |n, i| [n, []] }.to_h

# binding.pry
size.upto(2020 - 1) do |i|
  last = numbers[i - 1]
  index_pair = turns[last]

  # binding.pry
  if index_pair.size == 2
    n = index_pair.reduce(:-).abs

    numbers << n

    sub = turns[n]
    if sub.nil?
      turns[n] = [i]
    else
      turns[n] = sub << i
      turns[n] = turns[n].sort[1..-1] if turns[n].size > 2
    end
  else
    n = 0
    numbers << n
    turns[n] = index_pair << i
    turns[n] = turns[n].sort[1..-1] if turns[n].size > 2
  end
end

# binding.pry

result = numbers.last

puts "Part One - The puzzle answer is #{result}"

# Part Two


result =

puts "Part Two - The puzzle answer is #{result}"
