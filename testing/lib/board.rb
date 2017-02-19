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

  def connect_four?(col, row)
    state = 0
    state  = connect_row?(row)
    if state == 0
      state = connect_col?(col)
    end
    if state == 0
      state = connect_diag?(col,row)
    end
    return state
  end

  def col_full?(col)
    @board[col].all? { |piece| piece != 0 }
  end

  def connect_row?(row)
    row_string = ""
    @board.each { |col| row_string += col[row].to_s }
    return check_four(row_string)
  end

  def connect_col?(col)
    col_string = @board[col].join
    return check_four(col_string)
  end

  def connect_diag?(c, r)
    found = 0
    found = connect_diag_f?(c, r)
    if found == 0
      found = connect_diag_b?(c, r)
    end
    return found
  end

  def connect_diag_f?(col, row)
    search = ""
    c = col
    r = row
    until c > 6 || r > 5
      search += @board[c][r].to_s
      c += 1 
      r += 1
    end
      c = col - 1
      r = row - 1
    until c < 0 || r < 0
      search = @board[c][r].to_s + search
      c -= 1
      r -= 1
    end
    return check_four(search)
  end

  def connect_diag_b?(col, row)
    search = ""
    c = col 
    r = row
    until c > 6 || r < 0
      search += @board[c][r].to_s
      c += 1 
      r -= 1
    end
      c = col - 1
      r = row + 1
    until c < 0 || r > 5
      search = @board[c][r].to_s + search
      c -= 1
      r += 1
    end
    return check_four(search)
  end

  def check_four(string)
    if string.include?("1111")
      return 1
    elsif string.include?("2222")
      return 2
    end
    return 0
  end
end