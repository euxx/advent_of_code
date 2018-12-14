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

# Slow version
# the_claim = CLAIMS.find { |current_claim| not_overlap?(current_claim) }

# Fast version
grids = Array.new(1000) { Array.new(1000, -1) }
overlaps = Array.new(CLAIMS.size) { false }

CLAIMS.each_with_index do |claim, index|
  coordinates(claim).each { |x, y|
    grid_value = grids[x][y]
    if grid_value != -1
      overlaps[index] = true
      overlaps[grid_value] = true
    end
    grids[x][y] = index
  }
end

the_id = overlaps.index(false) + 1

puts "Part Two - The ID of the only claim that doesn't overlap is #{the_id}"
