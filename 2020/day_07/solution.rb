input = File.readlines("./2020/day_07/input.txt")

RULES = # {color_a => {color_b => n1, color_c => n2}}
  input.each_with_object({}) do |line, rules|
    color = line.scan(/\A\w+ \w+/).first
    sub_rules = line.scan(/(\d+) (\w+ \w+)/).map do |n, c|
      [c, n.to_i]
    end

    rules[color] = sub_rules.to_h
  end

# Part One

def cotain_any_shiny_gold?(colors)
  return false if colors.empty?

  colors.any? do |color|
    sub_colors = RULES[color].keys
    return true if sub_colors.include?('shiny gold')

    cotain_any_shiny_gold?(sub_colors)
  end
end

rules = RULES.each_value.select do |sub_rules|
  cotain_any_shiny_gold?(sub_rules.keys)
end

result = rules.count

puts "Part One - The puzzle answer is #{result}"

# Part Two

def total_bags(sub_rules)
  sub_rules.sum do |color, number|
    number + number * total_bags(RULES[color])
  end
end

result = total_bags(RULES['shiny gold'])

puts "Part Two - The puzzle answer is #{result}"
