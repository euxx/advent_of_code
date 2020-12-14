input = File.readlines("./2020/day_14/input.txt")

program = []
group = {}
input_size = input.size

input.each_with_index do |line, index|
  line = line.delete("\n")

  if line.start_with?('mask')
    group = {mask: line[7..-1], mems: []}
  else
    left, value = line.split('] = ')
    address = left[4..-1]
    group[:mems] << [address.to_i, value.to_i]

    program << group if input[index + 1]&.start_with?('mask') || index == input_size - 1
  end
end

require "pry"

# Part One

mem = []

program.each do |group|
  mask = group[:mask].reverse.chars
  size = mask.size

  group[:mems].each do |address, value|
    masked = '0' * size

    value.to_s(2).reverse.chars.each_with_index do |char, index|
      masked[index] = char
    end

    mask.each_with_index do |char, index|
      next if char == 'X'

      masked[index] = char
    end

    mem[address] = masked.reverse.to_i(2)
  end
end

result = mem.compact.sum

puts "Part One - The puzzle answer is #{result}"

# Part Two

mem = []

program.each do |group|
  mask = group[:mask].reverse.chars
  size = mask.size

  group[:mems].each do |address, value|
    masked = '0' * size

    address.to_s(2).reverse.chars.each_with_index do |char, index|
      masked[index] = char
    end

    count = 0
    indexes = []

    mask.each_with_index do |char, index|
      next if char == '0'

      masked[index] = char

      if char == 'X'
        count += 1
        indexes << index
      end
    end

    # count = 0
    # indexes = []

    # masked.chars.each_with_index do |char, index|
    #   if char == 'X'
    #     count += 1
    #     indexes << index
    #   end
    # end

    # count = masked.count('X')
    next if count == 0

    groups = ['0', '1']
    (count - 1).times { |_| groups = groups.product(['0', '1']) }

    groups = groups.map(&:flatten)
    # indexes = count.times.map do |_|
    #   index = masked =~ /X/
    #   masked[index] = 'x'
    #   index
    # end

    groups.each do |groupp|
      groupp.each_with_index do |n, index|
        masked[indexes[index]] = n
      end

      mem[masked.reverse.to_i(2)] = value
    end
  end
end

# binding.pry

result = mem.compact.sum

puts "Part Two - The puzzle answer is #{result}"
