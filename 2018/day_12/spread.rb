require "pry"

input = File.readlines("./input.txt")

INITIAL = input.first.chomp[15..-1]
rules = input[2..-1].map { |rule| rule.chomp.split(' => ') }
EXIST_RULES = rules.each_with_object([]) { |rule, rules| rules << rule.first if rule.last == '#' }
EMPTY_RULES = rules.each_with_object([]) { |rule, rules| rules << rule.first if rule.last == '.' }

def current_state(initial, index)
  (index < 0 || index > initial.size - 1) ? '.' : initial[index]
end

def rule(initial, index)
  "#{current_state(initial, index - 2)}#{current_state(initial, index - 1)}#{initial[index]}#{
     current_state(initial, index + 1)}#{current_state(initial, index + 2)}"
end

def next_state(rule)
  EXIST_RULES.include?(rule) && !EMPTY_RULES.include?(rule) ? '#' : '.'
end

def final_state(generations)
  initial = INITIAL
  current = ''
  count = 0
  generations.times do
    current = ''
    if (next_left_side_state = next_state("...#{initial[0..1]}")) == '#'
      current = next_left_side_state
      count += 1
    end

    initial.each_char.with_index { |char, index|
      current << next_state(rule(initial, index))
    }

    next_right_side_state = next_state("#{initial[-2..-1]}...")
    current << next_right_side_state if next_right_side_state == '#'
    initial = current
  end
  [current, count]
end

def sum(state)
  current, count = state
  current.chars.map.with_index { |char, index| char == '#' ? index - count : 0 }.sum
end

# Part One

the_sum = sum(final_state(20))

puts "Part 1: - After 20 generations, the sum of the numbers of all pots which contain a plant is #{the_sum}"

# Part Two

the_big_sum = sum(final_state(50000000000))

puts "Part 2: - After fifty billion (50000000000) generations, the sum of the numbers of all pots which contain a plant is #{the_big_sum}"
