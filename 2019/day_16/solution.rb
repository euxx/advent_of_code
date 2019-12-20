DATA = File.readlines("./2019/day_16/input.txt")
SIGNAL = DATA.first.to_i.digits.reverse
BASE_PATTERN = [0, 1, 0, -1]

require "pry"

def patterns(size)
  1.upto(size).map do |index|
    pattern = BASE_PATTERN.flat_map { |digit| Array.new(index, digit) }
    pattern = (pattern * ((size + 0.1) / pattern.size).ceil) if pattern.size <= size
    pattern[1..size]
  end
end

# Part One

def phase(signal, patterns)
  signal.map.with_index do |digit, index|
    signal.zip(patterns[index]).sum do |signal_digit, pattern_digit|
      signal_digit * pattern_digit rescue binding.pry
    end.abs.digits[0]
  end
end

def phases(signal, patterns, n)
  n.times.reduce(signal) { |signal| phase(signal, patterns) }
end

patterns = patterns(SIGNAL.size)

answer1 = phases(SIGNAL, patterns, 100)[0..7].join

puts "Part One - The puzzle answer is #{answer1}"

# Part Two

real_signal = SIGNAL * 10000
# patterns = patterns(real_signal.size)
offset = DATA.first[0..6].to_i + 1

signal = real_signal[offset..-1]

def calc(signal, sum, result)
  return result.reverse if signal.empty?
  new_sum = signal.pop + sum

  ssum = (new_sum % 10).abs
  new_result = result << ssum
  calc(signal, new_sum, new_result)
end

result = 100.times.reduce(signal) { |signal| calc(signal, 0, []) }

binding.pry
# phases(real_signal, patterns, 100)[(offset + 1)..(offset + 8)]

answer2 = phases(SIGNAL.reverse, patterns, 100)
# answer2 = nil
# 52541026

puts "Part Two - The puzzle answer is #{answer2}"

# https://www.reddit.com/r/adventofcode/comments/eblosu/day_16_mathvisual_explanation_and_thoughts/