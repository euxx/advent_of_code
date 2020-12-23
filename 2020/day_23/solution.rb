input = 925176834

cups = input.digits.reverse

def move(cups, n)
  size = n > 100 ? 1000000 : cups.size
  cups = n > 100 ? cups + (10..size).to_a : cups.dup
  i = 0

  n.times do
    current = cups[i]
    i1, i2, i3 = (i + 1) % size, (i + 2) % size, (i + 3) % size
    pick_up = [cups[i1], cups[i2], cups[i3]]
    cups -= pick_up

    min, max = cups.minmax
    dest = current - 1
    dest = max if dest < min

    if pick_up.include?(dest)
      while pick_up.include?(dest)
        dest -= 1
        dest = max if dest < min
      end
    end

    index = cups.index(dest)
    cups.insert((index + 1) % size, *pick_up)

    i = (cups.index(current) + 1) % size
  end

  cups
end

# Part One

final = move(cups, 100)
i = final.index(1)

result = (final + final)[i+ 1..i + final.size - 1].join

puts "Part One - The puzzle answer is #{result}"

# Part Two

final = move(cups, 10000000)
i = final.index(1)

result = final[i + 1] * final[i + 2]

puts "Part Two - The puzzle answer is #{result}"
