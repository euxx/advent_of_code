input = '12,20,0,6,1,17,7'

numbers = input.split(',').map(&:to_i)

def number_on_nth(numbers, nth)
  history = numbers.map.with_index { |n, i| [n, [i]] }.to_h

  numbers.size.upto(nth - 1) do |i|
    last = numbers[i - 1]
    x, y = history[last]

    n = y ? y - x : 0
    numbers << n

    x, y = history[n] || []
    history[n] = x ? [y || x, i] : [i]
  end

  numbers[nth - 1]
end

# Part One

result = number_on_nth(numbers, 2020)

puts "Part One - The puzzle answer is #{result}"

# Part Two

result = number_on_nth(numbers, 30000000)

puts "Part Two - The puzzle answer is #{result}"
