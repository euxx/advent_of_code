DATA = File.readlines("./2019/day_05/input.txt")
CODES = DATA.first.split(',').map(&:to_i)
CODES_SIZE = CODES.size

# Part One

def outputs(codes = CODES.dup, index = 0, outputs = '', input = 1)
  code = codes[index].digits
  opcode = code[1].to_i * 10 + code[0]
  return outputs.to_i if opcode == 99

  index_at = ->(mode, index) { mode == 1 ? index : codes[index] % CODES_SIZE }
  index1 = index_at.call(code[2], index + 1)
  index2 = index_at.call(code[3], index + 2)
  index3 = index_at.call(code[4], index + 3)
  value1 = codes[index1]
  value2 = codes[index2]

  case opcode
  when 1
    codes[index3] = value1 + value2
  when 2
    codes[index3] = value1 * value2
  when 3
    codes[index1] = input
  when 4
    outputs << value1.to_s
  when 5
    value1 != 0 ? index = value2 : index += 3
  when 6
    value1 == 0 ? index = value2 : index += 3
  when 7
    codes[index3] = value1 < value2 ? 1 : 0
  when 8
    codes[index3] = value1 == value2 ? 1 : 0
  end

  if [1, 2, 7, 8].include?(opcode)
    index += 4
  elsif [3, 4].include?(opcode)
    index += 2
  end

  outputs(codes, index, outputs)
end

answer1 = outputs

puts "Part One - The puzzle answer is #{answer1}"

# Part Two

answer2 = outputs(CODES.dup, 0, '', 5)

puts "Part Two - The puzzle answer is #{answer2}"
