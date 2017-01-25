class Board
  def initialize
    @board = Array.new(9,0)
    @display = (0..8).to_a
  end

  def display
    @board.each_with_index do |state, i|
      if state == 0
        @display[i] = i.to_s
      elsif state == 1
        @display[i] = "X"
      elsif state == 2
        @display[i] = "O"
      else
        put "Error: Invalid position state in board memory"
      end
    end
    puts
    puts "   |   |   "
    puts " " + @display[0] + " | " + @display[1] + " | " + @display[2]
    puts "   |   |   "
    puts "---+---+---"
    puts "   |   |   "
    puts " " + @display[3] + " | " + @display[4] + " | " + @display[5]
    puts "   |   |   "
    puts "---+---+---"
    puts "   |   |   "
    puts " " + @display[6] + " | " + @display[7] + " | " + @display[8]
    puts "   |   |   "
    puts
  end

  def play_1(move)
    if confirm(move)
      @board[move] = 1
    end
  end

  def play_2(move)
    if confirm(move)
      @board[move] = 2
    end
  end

  def confirm(move)
    if move <= 0 && move <= 8 && board[move] == 0
      return true
    else
      return false
    end
  end

  def check_win
    if @display[0] == @display[1] && 
  end

  def start
    puts
    puts "Thanks for playing tic-tac-toe! Please start with player 1 (X)."
    puts "---------------------------------------------------------------"
    display
    print "Enter the location you would like to play: "

  end
end

board = Board.new
board.start
