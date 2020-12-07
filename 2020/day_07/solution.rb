input = File.readlines("./2020/day_07/input.txt")

RULES = # {color_a => {color_b => n1, color_c => n2}}
  input.each_with_object({}) do |line, rules|
    line = line.delete("\n")
    string = ' contain no other bags.'
    split_string = line.end_with?(string) ? string : ' contain '

    hd, tl = line.split(split_string)
    color = hd.split(' ')[0..-2].join(' ')
    sub_rules =
      if tl
        tl[0..-2].split(', ')
                 .map do |sub_rule|
                    sub_rule = sub_rule.split(' ')
                    sub_color = sub_rule[1..-2].join(' ')
                    number = sub_rule[0].to_i

                    [sub_color, number]
                 end
      else
        []
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

rules = RULES.select do |color, sub_rules|
  colors = sub_rules.keys
  next true if colors.include?('shiny gold')

  cotain_any_shiny_gold?(colors)
end

result = rules.count

puts "Part One - The puzzle answer is #{result}"

# Part Two

def total_bags(sub_rules)
  return 0 if sub_rules.empty?

  sub_rules.sum do |color, number|
    number + number * total_bags(RULES[color])
  end
end

result = total_bags(RULES['shiny gold'])

puts "Part Two - The puzzle answer is #{result}"
