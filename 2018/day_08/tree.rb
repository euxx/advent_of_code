require "pry"

raw_tree = File.readlines("./input.txt")[0]

class Node
  attr_accessor :child_nodes, :metadata_entries

  def initialize
    @child_nodes ||= []
    @metadata_entries ||= []
  end
end

def parse(raw_tree, index = 0, parent = Node.new)
  quantity_of_child_nodes = raw_tree[index]
  quantity_of_metadata_entries = raw_tree[index + 1]

  node = Node.new
  index += 2

  quantity_of_child_nodes.times do
    node, index = parse(raw_tree, index, node)
  end

  node.metadata_entries = raw_tree[index..index + quantity_of_metadata_entries - 1]
  index += quantity_of_metadata_entries

  parent.child_nodes << node

  [parent, index]
end

the_tree = parse(raw_tree.split.map(&:to_i))[0]

# Part One

def sum_of_metadata_entries(tree)
  sum = 0
  unless tree.child_nodes.empty?
    tree.child_nodes.each do |node|
      sum += sum_of_metadata_entries(node)
    end
  end
  sum += tree.metadata_entries.sum
end

the_sum = sum_of_metadata_entries(the_tree)

puts "Part 1: - The sum of all metadata entries is #{the_sum}"

# Part Two

def value(node)
  value = 0
  if node.child_nodes.empty?
    value += node.metadata_entries.sum
  else
    node.metadata_entries.each do |metadata_entry|
      child_node = node.child_nodes[metadata_entry - 1]
      if metadata_entry > 0 && child_node
        value += value(child_node)
      end
    end
  end
  value
end

the_value = value(the_tree.child_nodes[0])

puts "Part 2: - The value of the root node is #{the_value}"
