input = File.readlines("./2020/day_13/input.txt")

earliest_timestamp = input.first.to_i

ids = input.last[0..-2].split(',').map do |id|
  id == 'x' ? id : id.to_i
end

# Part One

ids_and_wait_time = (ids - ['x']).map do |id|
  timestamp = ((earliest_timestamp / id) + 1) * id

  [id, timestamp - earliest_timestamp]
end

id, wait_time = ids_and_wait_time.min_by(&:last)

result = id * wait_time

puts "Part One - The puzzle answer is #{result}"
