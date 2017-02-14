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
    elsif col_full?(move.to_i)
      return false
    end
    return true
  end

  def play(key, col)
    row = @board[col].find_index(0)
    @board[col][row] = key
    return row
  end

  def col_full?(col)
    @board[col].all? { |piece| piece != 0 }
  end

  def connect_row?(row)
    row_string = ""
    @board.each { |col| row_string += col[row].to_s }
    if row_string.include?("1111")
      return 1
    elsif row_string.include?("2222")
      return 2
    end
    return 0
  end

  def connect_col?(col)
    if @board[col].join.include?("1111")
      return 1
    elsif @board[col].join.include?("2222")
      return 2
    end
    return 0
  end

end