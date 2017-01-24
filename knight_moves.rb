

def possible_positions_from(position)
  possible_positions = [[position[0]-2,position[1]-1],[position[0]-2,position[1]+1],[position[0]+2,position[1]-1],[position[0]+2,position[1]+1],[position[0]-1,position[1]-2],[position[0]-1,position[1]+2],[position[0]+1,position[1]-2],[position[0]+1,position[1]+2]]
  possible_positions.keep_if do |p|
    p[0] >=0 && p[0] < 8 && p[1] >= 0 && p[1] <8
  end
  return possible_positions
end

def knight_moves(start, finish)
  moves = Hash.new([])
  visited = Hash.new(false)
  populating_graph = true
  queue = [start]
  while populating_graph
    position = Object.new
    position = queue.shift

 #   puts "We just shifted off #{position}"
#    p position
    visited[position.clone] = true
    possible_positions = possible_positions_from(position)

    possible_positions.each do |p|
      if visited[p] == false
 #       puts "Pushing #{p} onto hash for #{position}"
        moves[position.clone].push(p)
#        p moves[position]
        visited[p] = true
        queue.push(p)
        if p == finish
          populating_graph = false
        end # if
      end # if
    end # do
    puts "End while"
 #   p moves.keys
 #   p moves[position]

  end # while





  path = []
  node = nil
  last = finish
=begin
  until last == start
    puts "Entered until loop"
    moves.each_value do |value|
      if value.include?(last)
        puts "Found that #{last}"
        path.unshift(last)
        last = moves.key(value)
      end
    end
  end



=begin
  visited = Hash.new(false)
  queue = [start]
  path = []
  path.push(start)
  while true
    current = queue.shift
    visited[current] = true
    if current == finish
      break
    end

    moves[current].each do |move|
      queue.push(move)
    end
  end
=end

  return moves
end




node = knight_moves([3,3],[4,3])
puts "#{node[[3,3]]}"
puts
puts "#{possible_positions_from([3,3])}"
