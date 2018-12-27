require "pry"

description = '411 players; last marble is worth 72059 points'

# description = '9 players; last marble is worth 25 points'    # 5 - 32
# description = '10 players; last marble is worth 1618 points' # high score is 8317
# description = '13 players; last marble is worth 7999 points' # high score is 146373
# description = '17 players; last marble is worth 1104 points' # high score is 2764
# description = '21 players; last marble is worth 6111 points' # high score is 54718
# description = '30 players; last marble is worth 5807 points' # high score is 37305

players_number, *, last_marble_number = description.split(/\D/).map(&:to_i)

class Marble
  attr_accessor :before, :after, :value

  def initialize(before = nil, after = nil, value)
    @before, @after, @value = before, after, value
  end

  def add_after(marble)
    after = self.after
    after.before = marble
    marble.before = self
    marble.after = after
    self.after = marble
  end

  def before_7
    before = self.before
    6.times { before = before.before }
    before
  end
end

def remove(marble)
  before = marble.before
  after = marble.after
  before.after = after
  after.before = before
end

def winning_score(players_number, last_marble_number)
  current_marble = Marble.new(nil, nil, 0)
  current_marble.before = current_marble
  current_marble.after = current_marble

  scores = Hash.new(0)
  players = (1..players_number).cycle
  players.next
  current_number = 1

  until current_number > last_marble_number
    player = players.next
    if current_number % 23 == 0
      marble_before_7 = current_marble.before_7
      scores[player] += (current_number + marble_before_7.value)
      current_marble = marble_before_7.after
      remove(marble_before_7)
    else
      marble = Marble.new(nil, nil, current_number)
      current_marble.after.add_after(marble)
      current_marble = marble
    end
    current_number += 1
  end
  scores.values.max
end

# Part One

the_score = winning_score(players_number, last_marble_number)

puts "Part 1: - The winning Elf's score is #{the_score}"

# Part Two

the_score = winning_score(players_number, last_marble_number * 100)

puts "Part 2: - The new winning Elf's score be if the number of the last marble were 100 times larger is #{the_score}"
