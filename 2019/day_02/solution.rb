DATA = File.readlines("./2019/day_02/input.txt")
CODES = DATA.first.split(',').map(&:to_i)
CODES_SIZE = CODES.size

# Part One

def zero_code(codes = CODES.dup, index = 0, input = [12, 2])
  codes[1..2] = input if index == 0
  input_index1 = codes[index + 1] % CODES_SIZE
  input_index2 = codes[index + 2] % CODES_SIZE
  output_index = codes[index + 3] % CODES_SIZE

  case codes[index]
  when 1
    codes[output_index] = codes[input_index1] + codes[input_index2]
  when 2
    codes[output_index] = codes[input_index1] * codes[input_index2]
  when 99
    return codes[0]
  end
  zero_code(codes, index + 4)
end

answer = zero_code

puts "Part One - The puzzle answer is #{answer}"

# Part Two

def find_the_input
  output = 19690720
  nums = (0..99).to_a
  inputs = nums.product(nums)
  index = 0

  until zero_code(CODES.dup, 0, inputs[index]) == output
    index += 1
  end

  inputs[index]
end

input = find_the_input
answer = input[0] * 100 + input[1]

puts "Part Two - The puzzle answer is #{answer}"
