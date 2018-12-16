require "pry"

string = File.readlines("./input.txt")[0]

def react?(letter1, letter2)
  letter1&.upcase == letter2.upcase && letter1 != letter2
end

def react(string)
  string.each_char.with_object('') { |letter, reacted|
    react?(reacted[-1], letter) ? reacted.chop! : reacted << letter
  }
end

def react_all(reacted = string)
  string = ''
  until reacted.size == string.size
    reacted = react(string = reacted)
  end
  reacted
end

# Part One

length = react_all(string).size

puts "Part 1: - The units remain after fully reacting the polymer after scanning is #{length}"

# Part Two

length = ('a'..'z').map { |letter|
  sub = string.gsub(/#{letter}|#{letter.upcase}/, '')
  react_all(sub).size
}.min

puts "Part 2: - The length of the shortest polymer can produce by removing all units of exactly one type and fully reacting the result is #{length}"
