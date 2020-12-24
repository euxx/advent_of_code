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

result = state.count { |_, v| v }

puts "Part One - The puzzle answer is #{result}"

# Part Two

100.times do
  vecs =  state.select { |_, v| v }.keys.map(&:rect)
  xmin, xmax = vecs.map(&:first).minmax
  ymin, ymax = vecs.map(&:last).minmax
  new_state = Hash.new(false)

  (xmin - 1..xmax + 1).each do |x|
    (ymin - 1..ymax + 1).each do |y|
      vec = Complex(x, y)
      count = VEC.count { |_, v| state[vec + v] }

      new_state[vec] = (state[vec] && [1, 2].include?(count)) || count == 2
    end
  end

  state = new_state
end

result = state.count { |_, v| v }

puts "Part Two - The puzzle answer is #{result}"
