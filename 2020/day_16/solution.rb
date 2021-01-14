input = File.read("./2020/day_16/input.txt")

data = input.split("\n\n")

rules = data[0].lines.map do |line|
  name, rest = line.split(':')
  sub_rules = rest.scan(/\d+/).each_slice(2).map do |b, e|
    b.to_i..e.to_i
  end

  [name, sub_rules]
end.to_h

all_rules = rules.values.flatten

my_ticket = data[1].scan(/\d+/).map(&:to_i)

nearby_tickets = data[2].lines[1..-1].map do |line|
  line.scan(/\d+/).map(&:to_i)
end

# Part One

invalid_values = nearby_tickets.flatten.select do |n|
  all_rules.all? { |range| !range.include?(n) }
end

result = invalid_values.sum

puts "Part One - The puzzle answer is #{result}"

# Part Two

valid_tickets = nearby_tickets.select do |ticket|
  ticket.all? do |n|
    all_rules.any? { |range| range.include?(n) }
  end
end

all_tickets = [my_ticket] + valid_tickets
size = my_ticket.size
index_range = 0..size - 1

name_with_valid_indexes = rules.map do |name, sub_rules|
  sub_index = index_range.select do |i|
    all_tickets.all? do |ticket|
      sub_rules.any? { |range| range.include?(ticket[i]) }
    end
  end

  [name, sub_index]
end

name_with_index = []
remain = name_with_valid_indexes

while (name, only_one_index = remain.find { _2.size == 1 })
  name_with_index << [name, only_one_index[0]]

  remain = remain.map { [_1, _2 - only_one_index] }
end

order_names = name_with_index.sort_by(&:last).map(&:first)

result = my_ticket.select.with_index do
  order_names[_2] =~ /departure/
end.reduce(:*)

puts "Part Two - The puzzle answer is #{result}"
