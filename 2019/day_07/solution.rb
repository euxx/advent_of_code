DATA = File.readlines("./2019/day_07/input.txt")
CODES = DATA.first.split(',').map(&:to_i)
CODES_SIZE = CODES.size

# Part One

def outputs(codes, index, outputs, input)
  code = codes[index].digits
  opcode = code[1].to_i * 10 + code[0]
  return (outputs == '' ? input[0] : outputs) if opcode == 99

  index_at = ->(mode, index) { mode == 1 ? index : codes[index % CODES_SIZE] % CODES_SIZE }
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
    codes[index1] = input.shift
  when 4
    return [codes, index + 2, value1]
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

  outputs(codes, index, outputs, input)
end

def signal(phase_setting_sequence)
  status = []
  result = []
  phase_setting_sequence.each do |phase_setting|
    result = outputs(CODES.dup, 0, '', [phase_setting, result[-1] || 0])
    status << result
  end

  indexes = (0..4).cycle
  until result.is_a?(Integer)
    index = indexes.next
    current = status[index]
    result = outputs(current[0], current[1], '', [result[-1]])
    status[index] = result
  end

  result
end

def max_signal(phase_setting_range)
  phase_setting_sequences =
    phase_setting_range.to_a
      .repeated_permutation(5).select { |sequence| sequence.uniq.size == 5 }

  signals = phase_setting_sequences.map(&method(:signal))

  signals.max
end

answer1 = max_signal(0..4)

puts "Part One - The puzzle answer is #{answer1}"

# Part Two

answer2 = max_signal(5..9)

puts "Part Two - The puzzle answer is #{answer2}"
