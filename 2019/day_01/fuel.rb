MASSES = File.readlines("./2019/day_01/input.txt")

# Part One

def fuel(mass)
  (mass.to_i / 3).floor - 2
end

sum = MASSES.sum(&method(:fuel))

puts "Part One - The puzzle answer is #{sum}"

# Part Two

def total_fuel(mass, total = 0)
  mass = fuel(mass)
  return total if mass <= 0
  total_fuel(mass, total += mass)
end

total_sum = MASSES.sum(&method(:total_fuel))

puts "Part Two - The puzzle answer is #{total_sum}"
