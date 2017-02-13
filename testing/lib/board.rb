class Board
  attr_accessor :board
  def initialize
    @board = Array.new(7){ Array.new(6, 0) }
#    @board = [[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0]]
  end

  def check(move)
    if move.length != 1
      return false
    end
    if move.ord < 48 || move.ord > 54 # ascii codes for '0' and '6'
      return false
    elsif is_full?(move.to_i)
      return false
    end
    return true
  end

  def play(key, col)
    row = @board[col].find_index(0)
    @board[col][row] = key
  end

  def is_full?(col)
    @board[col].all? { |piece| piece != 0 }
  end

end