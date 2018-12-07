IDs = File.readlines("./input.txt")

# Part One

def any_letter_appear_times?(id, times)
  id.chars.group_by(&:itself).any? { |_letter, group| group.count == times }
end

count_twice       = IDs.count { |id| any_letter_appear_times?(id, 2) }
count_three_times = IDs.count { |id| any_letter_appear_times?(id, 3) }
checksum = count_twice * count_three_times

puts "Part One - The checksum for the list of box IDs is #{checksum}"

# Part Two

common_letters = nil

while common_letters.nil?
  current_id = IDs.shift
  IDs.each do |id|
    differences = current_id.chars.zip(id.chars).map { |char1, char2| char1 != char2 }
    if differences.count(true) == 1
      current_id.slice!(differences.index(true))
      common_letters = current_id
    end
  end
end

puts "Part Two - The common letters between the two correct box IDs is #{common_letters}"
