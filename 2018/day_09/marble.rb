require "pry"

description = '411 players; last marble is worth 72059 points'

# description = '9 players; last marble is worth 25 points'    # 5 - 32
# description = '10 players; last marble is worth 1618 points' # high score is 8317
# description = '13 players; last marble is worth 7999 points' # high score is 146373
# description = '17 players; last marble is worth 1104 points' # high score is 2764
# description = '21 players; last marble is worth 6111 points' # high score is 54718
# description = '30 players; last marble is worth 5807 points' # high score is 37305

players_number, *, last_marble_number = description.split(/\D/).map(&:to_i)

def winning_score(players_number, last_marble_number)
  circle = [0, 1]
  scores = Hash.new(0)
  current_marble_index = 1
  players = (1..players_number).cycle
  players.next
  next_number = 2

  until next_number > last_marble_number
    player = players.next
    if next_number % 23 == 0
      index = current_marble_index - 7
      index += circle.size if index < 0
      scores[player] += (next_number + circle[index])
      circle.delete_at(index)
    else
      index = current_marble_index + 2
      index = index % circle.size if index > circle.size
      circle.insert(index, next_number)
    end
    current_marble_index = index
    next_number += 1
  end

  scores.values.max
end

# Part One

the_score = winning_score(players_number, last_marble_number)

puts "Part 1: - The winning Elf's score is #{the_score}"

# Part Two

the_score = winning_score(players_number, last_marble_number * 100)

puts "Part 2: - The new winning Elf's score be if the number of the last marble were 100 times larger is #{the_score}"
