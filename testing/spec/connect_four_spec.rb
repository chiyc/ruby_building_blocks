require 'connect_four.rb'

describe "connect four game" do
  let(:game) { ConnectFour.new}
  
  describe "#initialize" do
    it "creates new board" do
      expect(game.board).to be_a(Board)
    end
    it "starts with empty board" do
      expect(game.board.board).to eq(Array.new(7, Array.new(6,0)))
    end

  end

  describe "#check(move)" do
    it "forbids invalid column move input" do
      expect(game.check("sd")).to be false
      expect(game.check("-1")).to be false
      expect(game.check("7")).to be false
      expect(game.check("7")).to be false
      expect(game.check("")).to be false
      expect(game.check("132")).to be false
    end
    it "forbids move in full column" do
      game.board.board[2].each_with_index { |x, i| game.board.board[2][i] = 1 }
      expect(game.check('2')).to be false
    end
  end
  
  context "playing a move" do
    describe "board" do
      it "recognizes full target columns" do
        game.board.board[2].each_with_index { |x, i| game.board.board[2][i] = 1 }
        expect(game.board.is_full?(2)).to be true
      end
    end

    it "drops first piece into selected column" do
      game.play('3')
      expect(game.board.board[3][0]).to eq(1)
    end

    it "changes current player to next player" do
      game.play('4')
      expect(game.current_player).to eq(2)
      game.play('1')
      expect(game.current_player).to eq(1)
    end

    it "correctly drops next piece on top of first piece" do
      game.play('3')
      game.play('2')
      expect(game.board.board[3][1]).to eq(2)
    end
  end
end