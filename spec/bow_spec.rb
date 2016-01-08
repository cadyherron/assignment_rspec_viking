# require_relative 'weapon'
require'./lib/weapons/bow'


describe Bow do

  let( :bow ) { Bow.new }
  let( :bow_6 ) { Bow.new(6)}

  describe "#initialize" do
    it "make sure bow's arrow count is readable" do
      expect(bow).to respond_to :arrows
    end

    it "starts with 10 arrows by default" do
      expect(bow.arrows).to eq(10)
    end

    it "can initialize with 6 arrows" do
      expect(bow_6.arrows).to eq(6)
    end

  end

end