input = 389125467

cups = input.digits.reverse

require "pry"

class Cup
  attr_accessor :value, :next

  def initialize(value)
    @value = value
  end

  def list
    a = [self]
    o = self.next
    until o == self
      a << o
      o = o.next
    end
    a
  end

  def values
    list.map(&:values)
  end
end

def move(cups, n = 10, huge: false)
  size = huge ? 1000000 : cups.size
  cups = huge ? cups + (10..size).to_a : cups.dup

  objects = cups.map { |c| Cup.new(c) }
  objects.each_with_index do |o, idx|
    o.next = objects[(idx + 1) % size]
  end
  current = objects.first
  # binding.pry

  n.times do |i|
    i1, i2, i3 = current.next, current.next.next, current.next.next.next
    pick_up = [i1, i2, i3]
    current.next = i3.next

    list = current.list
    values = list.map(&:value)
    min, max = values.minmax
    dest = current.value - 1
    dest = max if dest < min

    pick_up_values = pick_up.map(&:value)

    if pick_up_values.include?(dest)
      while pick_up_values.include?(dest)
        dest -= 1
        dest = max if dest < min
      end
    end


    d_o = list.find { |oo| oo.value == dest }
    old = d_o.next
    d_o.next = i1
    i3.next = old
    # binding.pry

    current = current.next
  end

  cups
end

# Part One

final = move(cups, 100)
i = final.find { |oo| oo.value == 1 }

result = i.next.list.map(&:value).join

puts "Part One - The puzzle answer is #{result}"

# Part Two

# final = move(cups, 10000000)
# i = final.index(1)

result = final[i + 1] * final[i + 2]

puts "Part Two - The puzzle answer is #{result}"
