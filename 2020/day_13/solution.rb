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

# Part Two

order_ids = ids.map.with_index do |id, index|
  id == 'x' ? nil : [id, index]
end.compact

first_id = order_ids.first.first
t = ((100000000000000 / first_id) + 1) * first_id
found = false

until found
  t += first_id

  found = order_ids[1..-1].all? do |id, index|
    timestamp = ((t / id) + 1) * id

    timestamp - t == index
  end
end

result = t

puts "Part Two - The puzzle answer is #{result}"
