require_relative "board.rb"
require_relative "interface.rb"

class ConnectFour
  include Interface
  attr_reader :board, :current_player, :turns

  def initialize
    @board = Board.new
    @current_player = 1
    @game_state = 0
    @turns = 0
  end

  def play(move)
    if @board.check(move)
      move = move.to_i
      row = @board.play(@current_player, move)
      @current_player = 3 - @current_player
      @turns += 1
      return row
    else
      return false
    end
  end

  def start
    until @game_state != 0
      display(board)
      puts
      r = false
      until r
        c = prompt_turn(@current_player)
        r = play(c)
      end
      puts
      c = c.to_i
      if @turns < 42
        @game_state = @board.connect_four?(c, r)
      else
        @game_state = @board.connect_four?(c, r)
        if @game_state == 0
          @game_state = 3
        end
      end     
    end # game end
    display(board)
    puts
    if @game_state == 1
      puts "Player 1 won!"
    elsif @game_state == 2
      puts "Player 1 won!"
    elsif @game_state == 3
      puts "Game draw!"
    end
    puts
  end
end

if __FILE__ == $0
  game = ConnectFour.new
  game.start
end