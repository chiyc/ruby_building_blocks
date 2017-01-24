def coord_to_key(coord)
  return coord[0] + 10*coord[1]
end

def key_to_coord(key)
  col = key % 10
  row = key / 10
  return [col,row]
end

def is_possible?(p)
  possible = true

  if p.class == Fixnum
    col = p % 10
    row = p / 10
  elsif p.class == Array
    col = p[0] % 10
    row = p[1] / 10
  else
    possible = false
  end

  if col > 7 || row < 0 || row > 7
    possible = false
  end

  return possible
end

def possible_positions_from(position)
  possible_positions = [[position[0]-2,position[1]-1],[position[0]-2,position[1]+1],[position[0]+2,position[1]-1],[position[0]+2,position[1]+1],[position[0]-1,position[1]-2],[position[0]-1,position[1]+2],[position[0]+1,position[1]-2],[position[0]+1,position[1]+2]]
  possible_positions.keep_if do |p|
    p[0] >=0 && p[0] < 8 && p[1] >= 0 && p[1] <8
  end
  return possible_positions
end

def knight_moves(start, finish)
  moves = Array.new
  visited = Array.new
  populating_graph = true
  queue = [start]
  while populating_graph
    position = coord_to_key(queue.shift)
    if moves[position] == nil
      moves[position] = []
    end
    visited[position] = true
    possible_positions = possible_positions_from(key_to_coord(position))

    possible_positions.each do |p|
      if visited[coord_to_key(p)] == nil
        moves[position].push(coord_to_key(p))
        visited[coord_to_key(p)] = true
        queue.push(p)
   #     puts "We pushed #{coord_to_key(p)} to the starting position of #{position}"
        if coord_to_key(p) == coord_to_key(finish)
          populating_graph = false
        end # if
      end # if
    end # do

  end # while

  path = []
  last = coord_to_key(finish)
  jumps = 0
  until last == coord_to_key(start)
#    puts "Searching for origin of #{last}"
    moves.each_with_index do |paths, key|
      if paths != nil
        if paths.include?(last)
  #        puts "Found #{last} came from #{key}"
          path.unshift(key_to_coord(last))
          last = key
          jumps += 1
        end
      end
    end
  end
  path.unshift(start)
  puts "You made it in #{jumps} moves! Here's your path:"
  path.each do |key|
    p key
  end
  return path
end

knight_moves([3,3],[4,3])
puts
puts knight_moves([0,0],[1,2]) == [[0,0],[1,2]]
