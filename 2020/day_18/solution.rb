input = File.readlines("./2020/day_18/input.txt")

# Part One

def evaluate(expression)
  if expression.include?('(')
    m = /\([^\(]*?\)/.match(expression)

    evaluate(m.pre_match + evaluate(m[0][1..-2]) + m.post_match)
  elsif IS_PART_2 && expression.include?('+')
    m = /(\d+ \+ \d+)/.match(expression)

    evaluate(m.pre_match + (eval m[0]).to_s + m.post_match)
  else
    total, *remain = expression.split(' ')

    until remain.empty?
      math, n, *remain = remain

      total = (eval total + math + n).to_s
    end

    total
  end
end

def total(input)
  input.sum { |expression| evaluate(expression).to_i }
end

IS_PART_2 = false

result = total(input)

puts "Part One - The puzzle answer is #{result}"

# Part Two

IS_PART_2 = true

result = total(input)

puts "Part Two - The puzzle answer is #{result}"
