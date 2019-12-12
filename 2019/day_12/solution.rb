DATA = File.readlines("./2019/day_12/input.txt")

def parse(line)
  line.delete("\n")[1..-2].split(', ')
      .map { |chars| chars.split('=').last.to_i }
end

def initial_moons
  DATA.map do |line|
    { position: parse(line), velocity: [0, 0, 0] }
  end
end

def step(moons, axis_index)
  positions = moons.map { |moon| moon[:position][axis_index] }

  moons.each_with_index do |moon, index|
    axis_position = positions[index]
    axis_velocity = moon[:velocity][axis_index]

    (positions - [axis_position]).each do |position|
      if axis_position > position
        axis_velocity -= 1
      elsif axis_position < position
        axis_velocity += 1
      end
    end

    moon[:velocity][axis_index] = axis_velocity
    moon[:position][axis_index] += axis_velocity
  end
end

# Part One

def steps(moons, steps)
  index = 0
  until index == steps
    moons = step(moons, 0)
    moons = step(moons, 1)
    moons = step(moons, 2)
    index += 1
  end
  moons
end

def total_energy(moons)
  moons.sum { |moon| moon[:position].sum(&:abs) * moon[:velocity].sum(&:abs) }
end

moons = steps(initial_moons, 1000)

answer1 = total_energy(moons)

puts "Part One - The puzzle answer is #{answer1}"

# Part Two

def total_steps(moons, axis_index)
  initial = initial_moons
  current = nil
  steps = 0
  until current == initial
    current = step(moons, axis_index)
    steps += 1
  end
  steps
end

moons = initial_moons
x_steps = total_steps(moons, 0)
y_steps = total_steps(moons, 1)
z_steps = total_steps(moons, 2)

answer2 = [x_steps, y_steps, z_steps].reduce(1, :lcm)

puts "Part Two - The puzzle answer is #{answer2}"
