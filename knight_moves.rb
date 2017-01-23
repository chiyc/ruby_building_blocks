require_relative 'bst.rb'

def knight_moves(start, finish)
  moves = Tree.new
  populating_tree = true
  queue = []
  queue.push(start)
  iteration = 0
  while populating_tree
    position = queue.shift
    moves.insert(position+[iteration])
    possible_positions = [[position[0]-2,position[1]-1],[position[0]-2,position[1]+1],[position[0]+2,position[1]-1],[position[0]+2,position[1]+1],[position[0]-1,position[1]-2],[position[0]-1,position[1]+2],[position[0]+1,position[1]-2],[position[0]+1,position[1]+2]]
    possible_positions.keep_if do |p|
      p[0] >=0 && p[0] < 8 && p[1] >= 0 && p[1] <8
    end
    iteration += 1
    possible_positions.each do |p|
      moves.insert(p+[iteration])
      queue.push(p)
      if moves.size > 63
        populating_tree = false
      end
    end
  end

  node = moves.breadth_first_search(finish)
  sequence = []
  until node == nil
    sequence.unshift(node.value)
    node = node.parent
  end
  return sequence

end

node = knight_moves([0,0],[1,2])
puts "#{node}"
