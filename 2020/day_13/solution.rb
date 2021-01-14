input = File.read("./2020/day_13/input.txt")

earliest_timestamp, *ids = input.scan(/\d+/).map(&:to_i)

# Part One

ids_and_wait_time = ids.map do |id|
  timestamp = ((earliest_timestamp / id) + 1) * id

  [id, timestamp - earliest_timestamp]
end

id, wait_time = ids_and_wait_time.min_by(&:last)

result = id * wait_time

puts "Part One - The puzzle answer is #{result}"

# Part Two

t = ids.shift
lcm = t

ids.zip(1..).each do |id, index|
  t += lcm until (t + index) % id == 0

  lcm = lcm.lcm(id)
end

result = t

puts "Part Two - The puzzle answer is #{result}"
