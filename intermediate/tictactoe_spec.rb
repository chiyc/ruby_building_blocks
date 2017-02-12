require 'tictactoe.rb'

describe "tic tac toe game" do
  let(:board) { Board.new }

  describe "#initialize" do
    it "sets board and game state" do
      expect(board.game_state).to eq(0)
      expect(board.board).to eq([0,0,0,0,0,0,0,0,0])
      expect(board.player).to eq(1)
    end
  end

  it "ends game when player 1 plays across top row" do
    board.board = [1,1,1,0,0,0,0,0,0]
    board.check_game
    expect(board.game_state).to eq(1)
  end


end

=begin
  
initialize
display
play_move
confirm
start
turn_prompt
end_prompt
check_game
=end