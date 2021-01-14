input = File.read("./2020/day_22/input.txt")

p1, p2 = input.split("\n\n").map { |p| p.lines.drop(1).map(&:to_i) }

def play(p1, p2, is_p2: false)
  p1, p2 = p1.dup, p2.dup
  history = {}

  until p1.empty? || p2.empty?
    if is_p2
      pair = [p1, p2].to_s
      history.key?(pair) ? (return [true, p1]) : history[pair] ||= true
    end

    c1, c2 = p1.shift, p2.shift

    is_p1_win, _ =
      if is_p2 && p1.size >= c1 && p2.size >= c2
        play(p1[0...c1], p2[0...c2], is_p2: true)
      else
        c1 > c2
      end

    is_p1_win ? p1.push(c1, c2) : p2.push(c2, c1)
  end

  p1.empty? ? [false, p2] : [true, p1]
end

def score(winner)
  (1..winner.size).to_a.reverse.zip(winner).sum { |i, c| i * c }
end

# Part One

_, winner = play(p1, p2)

result = score(winner)

puts "Part One - The puzzle answer is #{result}"

# Part Two

_, winner = play(p1, p2, is_p2: true)

result = score(winner)

puts "Part Two - The puzzle answer is #{result}"
