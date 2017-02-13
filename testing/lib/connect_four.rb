require "board.rb"
require "interface.rb"

class ConnectFour
  include Interface
  attr_reader :board, :current_player

  def initialize
    @board = Board.new
    @current_player = 1
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
end