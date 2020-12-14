input = File.readlines("./2020/day_14/input.txt")

program = []
group = {}

input.each_with_index do |line, index|
  line = line.delete("\n")

  if line.start_with?('mask')
    group = {mask: line[7..-1], mems: []}
  else
    group[:mems] << line.scan(/\d+/).map(&:to_i)

    program << group if input[index + 1]&.start_with?('mask') || input[index + 1].nil?
  end
end

# Part One

mem = {}

program.each do |group|
  mask = group[:mask].chars

  group[:mems].each do |address, value|
    masked = ''

    value.to_s(2).rjust(36, '0').chars.zip(mask).each do |bit_v, bit_m|
      masked << (bit_m == 'X' ? bit_v : bit_m)
    end

    mem[address] = masked.to_i(2)
  end
end

result = mem.values.sum

puts "Part One - The puzzle answer is #{result}"

# Part Two

def floating_bits(mask)
  indexes = mask.each_index.select { |index| mask[index] == 'X' }

  ['0', '1'].repeated_permutation(indexes.size).map do |bits|
    indexes.zip(bits)
  end
end

mem = {}

program.each do |group|
  mask = group[:mask].chars

  floating_bits = floating_bits(mask)

  group[:mems].each do |address, value|
    masked = ''

    address.to_s(2).rjust(36, '0').chars.zip(mask).each do |bit_a, bit_m|
      masked << (bit_m == '0' ? bit_a : bit_m)
    end

    floating_bits.each do |bits|
      bits.each { |index, bit| masked[index] = bit }

      mem[masked.to_i(2)] = value
    end
  end
end

result = mem.values.sum

puts "Part Two - The puzzle answer is #{result}"
