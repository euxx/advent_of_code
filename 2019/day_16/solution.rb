DATA = File.readlines("./2019/day_16/input.txt")
SIGNAL = DATA.first.to_i.digits.reverse
BASE_PATTERN = [0, 1, 0, -1]

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
patterns = patterns(real_signal.size)
offset = DATA.first[0..6].to_i

answer2 = phases(real_signal, patterns, 100)[(offset + 1)..(offset + 8)]

puts "Part Two - The puzzle answer is #{answer2}"
