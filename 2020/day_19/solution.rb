input_1 = File.readlines("./2020/day_19/input_1.txt")
input_2 = File.readlines("./2020/day_19/input_2.txt")

messages = input_2.map(&:strip)

RULES = input_1.map do |line|
  n, remain = line.strip.split(': ')

  [n, remain.split(' ')]
end.to_h

def regex_rule(n)
  RULES[n].map do |v|
   'ab|' =~ /#{v}/ ? v : "(#{regex_rule(v)})"
  end.join
end

# Part One

regex_rule = regex_rule('0')

result = messages.grep(/\A#{regex_rule}\z/).size

puts "Part One - The puzzle answer is #{result}"

# Part Two

regex_rules = (RULES.keys - %w[0 8 11])
  .map { |n| [n, regex_rule(n)] }
  .to_h

r42 = regex_rules['42']
r31 = regex_rules['31']
r11 = ("1".."10").map do |i|
  "((#{r42}){#{i}}(#{r31}){#{i}})"
end.join('|')

result = messages.grep(/\A(#{r42})+(#{r11})\z/).size

puts "Part Two - The puzzle answer is #{result}"
