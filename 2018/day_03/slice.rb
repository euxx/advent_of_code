raw_claims = File.readlines("./input.txt")

def parse(raw_claim)
  id, x_axis, y_axis, wide, _, tall = raw_claim.scan(/\d+|[A-Za-z]+/).map(&:to_i)

  {
    id: id,
    x_axis: x_axis,
    y_axis: y_axis,
    wide: wide,
    tall: tall,
  }
end

def coordinates(claim)
  x_axis_range = (claim[:x_axis] + 1)..(claim[:x_axis] + claim[:wide])
  y_axis_range = (claim[:y_axis] + 1)..(claim[:y_axis] + claim[:tall])
  x_axis_range.to_a.product(y_axis_range.to_a)
end

CLAIMS = raw_claims.map(&method(:parse))

# Part One

count_overlap =
  CLAIMS.flat_map { |claim| coordinates(claim) }
        .group_by(&:itself)
        .count { |_coordinate, group| group.size > 1 }

puts "Part One - The number of square inches of fabric are within two or more claims is #{count_overlap}"

# Part Two

def not_overlap?(current_claim)
  (CLAIMS - [current_claim]).all? do |claim|
    (coordinates(current_claim) & coordinates(claim)).empty?
  end
end

the_claim = CLAIMS.find { |current_claim| not_overlap?(current_claim) }

puts "Part Two - The ID of the only claim that doesn't overlap is #{the_claim[:id]}"
