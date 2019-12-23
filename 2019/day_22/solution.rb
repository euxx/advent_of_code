DATA = File.readlines("./2019/day_22/input.txt")

# Part One

def cards(number)
  (0...number).to_a
end

def new_stack(cards)
  cards.reverse
end

def cut(cards, n)
  n > 0 ? cards + cards.shift(n) : cards.pop(-n) + cards
end

def increment(cards, n)
  size = cards.size
  cards.each_with_index.with_object([]) do |(card, index), new_cards|
    new_index = (index * n) % size
    new_cards[new_index] = card
  end
end

def process(cards)
  DATA.reduce(cards) do |cards, line|
    parts = line.delete("\n").split
    next new_stack(cards) if parts[-1] == 'stack'

    n = parts[-1].to_i
    parts[0] == 'cut' ? cut(cards, n) : increment(cards, n)
  end
end

cards = cards(10007)
result = process(cards)

answer1 = result.index(2019)

puts "Part One - The puzzle answer is #{answer1}"

# Part Two

result = []

answer2 = result[2020]

puts "Part Two - The puzzle answer is #{answer2}"
