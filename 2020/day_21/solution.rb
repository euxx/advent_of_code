input = File.readlines("./2020/day_21/input.txt")

foods = input.map do |line|
  goods, bads = line.strip.split(' (')

  [goods.split(' '), bads[9..-2].split(', ')]
end

bad_names = foods.flat_map(&:last).uniq
bads = {}

bad_names.each do |bad|
  bads[bad] = foods.select { |_, bs| bs.include?(bad) }
                     .map(&:first)
                     .reduce(:&)
end

# Part One

good_names = foods.flat_map(&:first)
normal_names = good_names - bads.values.flatten

result = foods.sum { |gs, _| (gs & normal_names).size }

puts "Part One - The puzzle answer is #{result}"

# Part Two

bads_match = {}

while (bad, good = bads.find { |_, gs| gs.size == 1 })
  bads_match[bad] = good.first
  bads.delete(bad)

  bads.each { |b, gs| bads[b] = gs - good }
end

result = bads_match.sort_by(&:first).map(&:last).join(',')

puts "Part Two - The puzzle answer is #{result}"
