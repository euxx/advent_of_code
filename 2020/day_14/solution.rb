input = File.readlines("./2020/day_14/input.txt")

program = []
group = {}

input.each_with_index do |line, index|
  line = line.delete("\n")

  if line.start_with?('mask')
    group = {mask: line[7..-1], mems: []}
  else
    left, value = line.split('] = ')
    address = left[4..-1]
    group[:mems] << [address.to_i, value.to_i]

    program << group if input[index + 1]&.start_with?('mask') || input[index + 1].nil?
  end
end

# Part One

mem = {}

program.each do |group|
  mask = group[:mask].reverse.chars

  group[:mems].each do |address, value|
    masked = '0' * 36

    value.to_s(2).reverse.each_char.with_index do |char, index|
      masked[index] = char
    end

    mask.each_with_index do |char, index|
      masked[index] = char unless char == 'X'
    end

    mem[address] = masked.reverse.to_i(2)
  end
end

result = mem.values.sum

puts "Part One - The puzzle answer is #{result}"

# Part Two

def floating_bits(mask)
  x_count = mask.count('X')
  x_indexes = []

  x_count.times do
    index = mask.index('X')
    x_indexes << index
    mask[index] = 'x'
  end

  floating_bits = ['0', '1']
  (x_count - 1).times { floating_bits = floating_bits.product(['0', '1']) }

  [x_indexes, floating_bits]
end

mem = {}

program.each do |group|
  mask = group[:mask].reverse.chars

  x_indexes, floating_bits = floating_bits(mask)

  group[:mems].each do |address, value|
    masked = '0' * 36

    address.to_s(2).reverse.chars.each_with_index do |char, index|
      masked[index] = char
    end

    mask.each_with_index do |char, index|
      masked[index] = char unless char == '0'
    end

    floating_bits.each do |bits|
      bits.flatten.each_with_index do |bit, index|
        masked[x_indexes[index]] = bit
      end

      mem[masked.reverse.to_i(2)] = value
    end
  end
end

result = mem.values.sum

puts "Part Two - The puzzle answer is #{result}"
