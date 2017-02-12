require "caesar_cipher.rb"

describe "the cipher function" do
  it "encodes 'To be or not to be' rot 1" do
    expect(caesar_cipher("To be or not to be", 1)).to eq("Up cf ps opu up cf")
  end
  it "encodes 'To be or not to be' rot 2" do
    expect(caesar_cipher("To be or not to be", 2)).to eq("Vq dg qt pqv vq dg")
  end
  it "encodes 'To be or not to be.' rot 22" do
    expect(caesar_cipher("To be or not to be.", 22)).to eq("Pk xa kn jkp pk xa.")
  end
  it "encodes 'That is the question!' rot 25" do
    expect(caesar_cipher("That is the question!", 25)).to eq("Sgzs hr sgd ptdrshnm!")
  end
end
