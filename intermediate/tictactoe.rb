class Board
  if __FILE__ != $0
    attr_accessor :board, :display, :player, :game_state
  end
  def initialize
    @board = Array.new(9,0)
    @display = (0..8).to_a
    @player = 1
    @game_state = 0 # = live, 1 = player1 win, 2 = player2 win, 3 = draw
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

  def play_move(player, move)
    if confirm(move)
      @board[move.to_i] = player
      @player = 3 - player
      return true
    end
    return false
  end

  def confirm(move)
    if move.ord >= 48 && move.ord <= 56
      move = move.to_i
    else
      return false
    end 
    if move >= 0 && move <= 8 && @board[move] == 0
      return true
    else
      return false
    end
  end

  def start
    puts
    puts "Thanks for playing tic-tac-toe! Please start with player 1 (X)."
    puts "---------------------------------------------------------------"
    until @game_state > 0
      turn_prompt(@player)
      check_game
    end
    end_prompt(@game_state)
  end

  def turn_prompt(player)
    display
    played = false
    until played == true
      print "Enter the location you would like to play for player #{player}: "
      move = gets.chomp
      played = play_move(@player, move)
      if played == false
        puts "Location not valid"
      end
    end
  end

  def end_prompt(state)
    if @game_state == 1
      display
      puts "Congratulations! Player 1 won the game!"
    elsif @game_state == 2
      display
      puts "Congratulations! Player 2 won the game!"
    elsif @game_state == 3
      display
      puts "Awesome game! Both players came to a draw!"
    end
  end
  
  def check_game
    if @board[0] != 0 && @board[0] == @board[1] && @board[1] == @board[2]
      @game_state = @board[0]
    elsif @board[3] != 0 && @board[3] == @board[4] && @board[4] == @board[5]
      @game_state = @board[3]
    elsif @board[6] != 0 && @board[6] == @board[7] && @board[7] == @board[8]
      @game_state = @board[6]
    elsif @board[0] != 0 && @board[0] == @board[3] && @board[3] == @board[6]
      @game_state = @board[0]
    elsif @board[1] != 0 && @board[1] == @board[4] && @board[4] == @board[7]
      @game_state = @board[1]
    elsif @board[2] != 0 && @board[2] == @board[5] && @board[5] == @board[8]
      @game_state = @board[2]
    elsif @board[0] != 0 && @board[0] == @board[4] && @board[4] == @board[8]
      @game_state = @board[0]
    elsif @board[6] != 0 && @board[6] == @board[4] && @board[4] == @board[2]
      @game_state = @board[6]
    elsif @board.all? { |x| x != 0 }
      @game_state = 3
    end
  end
end

if __FILE__ == $0
  board = Board.new
  board.start
end