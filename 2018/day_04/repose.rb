require "pry"

raw_records = File.readlines("./input.txt")

def parse(raw_record)
  row = raw_record.scan(/\d+|[A-Za-z]+/)
  _, month, day, hour, minute = row[0..4]
  rest = row[5..-1]
  action = rest[-2..-1].join(' ')
  guard_id = rest[1].to_i if rest.size > 2

  {
    date: (month + day).to_i,
    hour: hour,
    minute: minute.to_i,
    guard_id: guard_id,
    action: action,
  }
end

def clean(raw_records)
  records =
    raw_records.map(&method(:parse))
               .sort_by { |record| [record[:date], record[:hour], record[:minute]] }

  # Add guard_id to records which have not
  records.map.with_index { |record, index|
    record[:guard_id] = records[index - 1][:guard_id] if record[:guard_id].nil?
    record
  }
end

def count_asleep_during_a_minute(records, minute)
  time_ranges =
    records.each_slice(2)
           .map { |record1, record2| (record1[:minute]..record2[:minute]) }
  time_ranges.count { |range| range.include? minute }
end

def the_minute_asleep_most(records)
  (0...60).max_by { |minute| count_asleep_during_a_minute(records, minute) }
end

records_group_by_guard_id =
  clean(raw_records).select { |record| record[:action] != 'begins shift' }
                    .group_by { |record| record[:guard_id] }

# Part One

records_with_id_and_asleep_time =
  records_group_by_guard_id.map { |id, group|
    asleep_time =
      group.each_slice(2).reduce(0) { |total_time, (record1, record2)|
        total_time += (record2[:minute] - record1[:minute])
      }
    [id, asleep_time]
  }

the_guard_id = records_with_id_and_asleep_time.max_by(&:last)[0]

records_of_the_guard =
  records_group_by_guard_id.find { |record| record[0] == the_guard_id }[1]

the_minute = the_minute_asleep_most(records_of_the_guard)

result = the_guard_id * the_minute

puts "Strategy 1: - The ID of the guard I chose multiplied by the minute I chose is #{result}"

# Part Two

results = records_group_by_guard_id.map { |id, group|
  the_minute = the_minute_asleep_most(group)
  [id, the_minute, count_asleep_during_a_minute(group, the_minute)]
}

the_result = results.max_by { |e| e[2] }

puts "Strategy 2: - The ID of the guard I chose multiplied by the minute I chose is #{the_result[0] * the_result[1]}"
