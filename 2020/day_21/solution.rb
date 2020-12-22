input = File.readlines("./2020/day_21/input.txt")

require 'pry'

data = input.map do |line|
   goods, bads = line.strip.split(' (')

   [goods.split(' '), bads[9..-2].split(', ')]
end

goods = data.flat_map(&:first)
bads = data.flat_map(&:last).uniq

h1 = bads.map do |bad|
  gs = data.select { |_, bs| bs.include?(bad) }
           .map(&:first)
           .reduce(:&)

  [bad, gs]
end.to_h

no = goods - h1.values.flatten

# Part One

result = data.sum { |gs, _| (gs & no).size }


puts "Part One - The puzzle answer is #{result}"

# Part Two

h2 = {}

until h2.size == bads.size
  h1.select { |_, gs| gs.size == 1 }
    .each do |bad, gs|
      h2[bad] = gs.first
      h1.delete(bad)
      h1.each do |b, g|
        h1[b] = g - gs
      end
    end
end


result = h2.sort_by { |bad, _| bad }.map(&:last).join(',')

puts "Part Two - The puzzle answer is #{result}"
