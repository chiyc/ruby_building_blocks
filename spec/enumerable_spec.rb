require_relative "../enumerable.rb"

describe Enumerable do
  let(:ary) { [1, 2, 3, 4, 5] }

  describe "#my_select" do 
    it "selects even" do
      expect(ary.my_select { |x| x.even? }).to eq([2, 4])
    end
    it "returns enum with no block" do
      expect(ary.my_select).to be_a Enumerable
    end
  end

  describe "#my_all?" do
    it "detects all < 6" do
      expect(ary.my_all? { |x| x < 6 }).to eq(true)
    end
    it "detects all not < 1" do
      expect(ary.my_all? { |x| x < 1 }).to eq(false)
    end
  end

  describe "#my_any?" do
    it "looks for non-nil with no block" do
      expect(ary.my_any?).to eq(true)
    end
    it "looks for nil" do
      expect(ary.my_any? { |x| x == nil }).to eq(false)
    end
    it "finds 2" do
      expect(ary.my_any? { |x| x == 2 }).to eq(true)
    end
  end
  
  describe "#my_none?" do
    it "looks for any nil with no block" do
      expect(ary.my_none?).to eq(false)
    end
    it "looks for nil" do
      expect(ary.my_none? { |x| x == nil }).to eq(true)
    end
    it "finds 2" do
      expect(ary.my_none? { |x| x == 2 }).to eq(false)
    end
  end
  
  describe "#my_map" do
    it "maps element doubling" do
      expect(ary.my_map { |x| x* 2 }).to eq([2, 4, 6, 8, 10])
    end
  end

  describe "#my_inject" do
    it "inject +" do
      expect(ary.my_inject(:+)).to eq(15)
    end 
    it "inject + starting at memo 10" do
      expect(ary.my_inject(10, :+)).to eq(25)
    end 
    it "inject with block |sum, n|" do
      expect(ary.my_inject { |sum, n| sum + n }).to eq(15)
    end
    it "inject with block |sum, n| on 50" do
      expect(ary.my_inject(50) { |sum, n| sum + n }).to eq(65)
    end
  end
end
