input = File.readlines("./2020/day_09/input.txt")

numbers = input.map { |line| line.delete("\n").to_i }

# Part One

step = 25

only_number = numbers[step..-1].find.with_index do |number, index|
  prev_nums = numbers[index..index + step - 1]
  !prev_nums.product(prev_nums).map(&:sum).include?(number)
end

result = only_number

puts "Part One - The puzzle answer is #{result}"

# Part Two

index = 0
found = false
contiguous_numbers = []

until found
  sub_index = 0
  finish = false

  until finish || found
    contiguous_numbers = numbers[index..sub_index]
    sum = contiguous_numbers.sum

    found = true if sum == only_number
    finish = true if sum > only_number

    sub_index += 1
  end

  index += 1
end

result = contiguous_numbers.minmax.sum

puts "Part Two - The puzzle answer is #{result}"
