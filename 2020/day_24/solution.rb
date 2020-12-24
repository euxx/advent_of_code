input = File.readlines("./2020/day_24/input.txt")

list = input.map { |line| line.strip.scan(/(e|se|sw|w|nw|ne)/).flatten }

VEC = {
  'e'  => Complex(1, -1),
  'se' => Complex(0, -1),
  'sw' => Complex(-1, 0),
  'w'  => Complex(-1, 1),
  'nw' => Complex(0, 1),
  'ne' => Complex(1, 0),
}

state = Hash.new(false)

list.each do |dirs|
  vec = dirs.reduce(Complex(0, 0)) { |vec, dir| vec += VEC[dir] }

  state[vec] = !state[vec]
end

# Part One

result = state.count(&:last)

puts "Part One - The puzzle answer is #{result}"

# Part Two

100.times do
  state.select { |_, is_black| is_black }.each do |vec, _|
    VEC.each_value { |v| state[vec + v] ||= false }
  end

  new_state = Hash.new(false)

  state.each do |vec, is_black|
    count = VEC.count { |_, v| state[vec + v] }

    new_state[vec] = (is_black && [1, 2].include?(count)) || count == 2
  end

  state = new_state
end

result = state.count(&:last)

puts "Part Two - The puzzle answer is #{result}"
