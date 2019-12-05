beginning = 264360
ending = 746325

# Part One

def meet?(number)
  digits_group = number.digits.reverse.each_cons(2)
  digits_group.all? { |x, y| x <= y } &&
  digits_group.any? { |x, y| x == y }
end

passwords = beginning.upto(ending).select(&method(:meet?))

answer1 = passwords.size

puts "Part One - The puzzle answer is #{answer1}"

# Part Two

def same?(digits)
  digits.uniq.size == 1
end

def also_meet?(number)
  digits = number.digits.reverse
  digits_group_2 = digits.each_cons(2).to_a
  digits_group_3 = digits.each_cons(3).to_a

  return false if same?(digits_group_3[0]) && same?(digits_group_3[3])
  return false if same?(digits_group_3[0]) && digits_group_3[3].uniq.size == 3
  return false if same?(digits_group_3[1]) && !same?(digits_group_2[-1])
  return false if same?(digits_group_3[2]) && !same?(digits_group_2[0])
  return false if same?(digits_group_3[3]) && digits_group_3[0].uniq.size == 3

  true
end

passwords = passwords.select(&method(:also_meet?))

answer2 = passwords.size

puts "Part Two - The puzzle answer is #{answer2}"
