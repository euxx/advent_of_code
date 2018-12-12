require "pry"

string = File.readlines("./input.txt")[0]

def react?(letter1, letter2)
  letter1.upcase == letter2.upcase && letter1 != letter2
end

def react(string)
  remain = ''
  skip = true
  string.each_char.with_index { |letter, index|
    if skip
      skip = false
      remain << letter if index == string.size - 1
    else
      prev_letter = string[index - 1]
      if react?(letter, prev_letter)
        skip = true
      else
        skip = false
        remain << prev_letter
        remain << letter if index == string.size - 1
      end
    end
  }
  remain
end

def react_all(string)
  remain = string
  string = ''
  until remain.size == string.size
    string = remain
    remain = react(string)
  end
  remain
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
