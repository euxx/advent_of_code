DATA = File.readlines("./2019/day_09/input.txt")
CODES = DATA.first.split(',').map(&:to_i)
CODES_SIZE = CODES.size

# Part One

def index_at(index, mode, base, codes)
  case mode
  when 1
    index
  when 2
    codes[index] + base
  else
    codes[index]
  end
end

def update_index(index, opcode)
  if [1, 2, 7, 8].include?(opcode)
    index + 4
  elsif [3, 4, 9].include?(opcode)
    index + 2
  else
    index
  end
end

def intcode_computer(codes:, base:, index:, input:, output:)
  code = codes[index].digits
  opcode = code[1].to_i * 10 + code[0]
  return output if opcode == 99

  index1 = index_at(index + 1, code[2], base, codes)
  index2 = index_at(index + 2, code[3], base, codes)
  index3 = index_at(index + 3, code[4], base, codes)
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
    output << value1.to_s
  when 5
    value1 != 0 ? index = value2 : index += 3
  when 6
    value1 == 0 ? index = value2 : index += 3
  when 7
    codes[index3] = value1 < value2 ? 1 : 0
  when 8
    codes[index3] = value1 == value2 ? 1 : 0
  when 9
    base += value1
  end

  {codes: codes, base: base, index: update_index(index, opcode), input: input, output: output}
end

def intcode_computer_outputs(codes: CODES.dup, base: 0, index: 0, input: 1, output: '')
  result = intcode_computer(codes: codes, base: base, index: index, input: input, output: output)
  until result.is_a?(String)
    result = intcode_computer(result)
  end
  result
end

answer1 = intcode_computer_outputs(input: 1)

puts "Part One - The puzzle answer is #{answer1}"

# Part Two

answer2 = intcode_computer_outputs(input: 2)

puts "Part Two - The puzzle answer is #{answer2}"
