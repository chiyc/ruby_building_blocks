class Board
  attr_accessor :board
  def initialize
    @board = Array.new(7){Array.new(6, 0)}
#    @board = [[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0]]
  end

  def play(key, col)
    
  end

  def is_full?(col)
    @board[col].all? { |piece| piece != 0 }
  end

end