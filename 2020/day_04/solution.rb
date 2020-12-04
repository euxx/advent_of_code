input = File.readlines("./2020/day_04/input.txt")

passports = input.join
                 .split("\n\n")
                 .map do |line|
                   line.tr("\n", ' ')
                       .split(' ')
                       .map { |kv| kv.split(':') }
                 end

required_fields = %w[byr iyr eyr hgt hcl ecl pid]

# Part One

valid_passports = passports.select do |fields|
  required_fields - fields.map(&:first) == []
end

result = valid_passports.size

puts "Part One - The puzzle answer is #{result}"

# Part Two

def valid_number?(value, range)
  number = Integer(value)
  range.include?(number)
rescue ArgumentError
  false
end

def valid_value?(field, value)
  case field
  when 'byr'
    valid_number?(value, (1920..2002))
  when 'iyr'
    valid_number?(value, (2010..2020))
  when 'eyr'
    valid_number?(value, (2020..2030))
  when 'hgt'
    type = value[-2..-1]
    value = value[0..-3]
    if type == 'cm'
      valid_number?(value, (150..193))
    elsif type == 'in'
      valid_number?(value, (59..76))
    end
  when 'hcl'
    valid_chars = ('0'..'9').to_a + ('a'..'f').to_a
    value[0] == '#' &&
    value[1..-1].chars.all? { |char| valid_chars.include?(char) }
  when 'ecl'
    %w[amb blu brn gry grn hzl oth].include?(value)
  when 'pid'
    value.size == 9 &&
    value.chars.all? { |char| ('0'..'9').include?(char) }
  else
    true
  end
end

valid_passports_with_valid_values = valid_passports.select do |fields|
  fields.all? { |field, value| valid_value?(field, value) }
end

result = valid_passports_with_valid_values.size

puts "Part Two - The puzzle answer is #{result}"
