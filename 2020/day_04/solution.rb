input = File.read("./2020/day_04/input.txt")

passports = input.split("\n\n")
                 .map do |line|
                   line.tr("\n", ' ')
                       .split(' ')
                       .map { |kv| kv.split(':') }
                 end

# Part One

required_fields = %w[byr iyr eyr hgt hcl ecl pid]

valid_passports = passports.select do |fields|
  required_fields - fields.map(&:first) == []
end

result = valid_passports.size

puts "Part One - The puzzle answer is #{result}"

# Part Two

def valid_value?(field, value)
  case field
  when 'byr'
    value.to_i.between?(1920, 2002)
  when 'iyr'
    value.to_i.between?(2010, 2020)
  when 'eyr'
    value.to_i.between?(2020, 2030)
  when 'hgt'
    if value =~ /cm/
      value.to_i.between?(150, 193)
    else
      value.to_i.between?(59, 76)
    end
  when 'hcl'
    value =~ /\A#[a-f\d]{6}\z/
  when 'ecl'
    %w[amb blu brn gry grn hzl oth].include?(value)
  when 'pid'
    value =~ /\A\d{9}\z/
  else
    true
  end
end

with_valid_values = valid_passports.select do |fields|
  fields.all? { |field, value| valid_value?(field, value) }
end

result = with_valid_values.size

puts "Part Two - The puzzle answer is #{result}"
