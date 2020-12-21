input_1 = File.readlines("./2020/day_19/input_1.txt")
input_2 = File.readlines("./2020/day_19/input_2.txt")

messages = input_2.map { |line| line.delete("\n") }

require "pry"

zero = []
rules = {}

input_1.each do |line|
  n, remain = line.delete("\n").split(': ')
  n = n.to_i

  base << [n, remain] if remain.size == 1
  next rules[n] = remain if remain.size == 1

  sub_rules = remain.split(' | ').map { |sub_rule| sub_rule.split(' ').map(&:to_i) }

  next zero = sub_rules.first if n == 0

  rules[n] = sub_rules
end


RULES = rules

def rule(n)
  sub_rules = RULES[n]
  return sub_rules if sub_rules == 'a' || sub_rules == 'b'

  sub_rules.map do |sub_rule|
    sub_rule.map { |m| rule(m) }
  end
end

zero = zero.map do |n|
  rule(n)
end

binding.pry

zero = zero.map { |a| a.flatten.join }

# Part One

valid = messages.select do |m|
  zero.include? m
end

result = valid.size

puts "Part One - The puzzle answer is #{result}"

# Part Two

result =

puts "Part Two - The puzzle answer is #{result}"
