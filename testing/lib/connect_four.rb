require_relative "board.rb"
require_relative "interface.rb"

class ConnectFour
  include Interface
  attr_reader :board, :current_player

  def initialize
    @board = Board.new
    @current_player = 1
    @game_state = 0
  end

  def play(move)
    if @board.check(move)
      move = move.to_i
      @board.play(@current_player, move)
      @current_player = 3 - @current_player
      return true
    else
      return false
    end
  end

  def start
    until @game_state != 0
      display(board)
      puts
      until play(prompt_turn(@current_player)); end
      puts
      
    end
  end
end

if __FILE__ == $0
  game = ConnectFour.new
  game.start
end