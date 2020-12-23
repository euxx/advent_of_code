# Key 1: change big data collection(like array) is slow, use linked objects instead
# Key 2: min, max is fixed in part 2

input = 925176834

cups = input.digits.reverse

class Cup
  attr_accessor :value, :next

  def initialize(value)
    @value = value
  end

  def values
    cup_values = [self.value]
    cup = self.next

    until cup == self
      cup_values << cup.value
      cup = cup.next
    end

    cup_values
  end
end

def move(cups, n)
  size = n > 100 ? 1000000 : cups.size
  cups = n > 100 ? cups + (10..size).to_a : cups.dup

  cups = cups.map { |c| Cup.new(c) }
  hash = {}
  cups.each_with_index do |cup, index|
    cup.next = cups[(index + 1) % size]

    hash[cup.value] = cup
  end

  current = cups.first
  min, max = 1, 1000000

  n.times do
    c1, c2, c3 = current.next, current.next.next, current.next.next.next
    pick_up = [c1.value, c2.value, c3.value]
    current.next = c3.next

    min, max = (current.values - pick_up).minmax if n == 100
    dest = current.value - 1
    dest = max if dest < min

    if pick_up.include?(dest)
      while pick_up.include?(dest)
        dest -= 1
        dest = max if dest < min
      end
    end

    c_dest = hash[dest]
    dest_next = c_dest.next
    c3.next = dest_next
    c_dest.next = c1

    current = current.next
  end

  hash
end

# Part One

hash = move(cups, 100)
cup = hash[1]

result = cup.values[1..-1].join

puts "Part One - The puzzle answer is #{result}"

# Part Two

hash = move(cups, 10000000)
cup = hash[1]

result = cup.next.value * cup.next.next.value

puts "Part Two - The puzzle answer is #{result}"
