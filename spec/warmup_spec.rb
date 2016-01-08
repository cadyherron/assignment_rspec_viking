require 'warmup'

describe Warmup do
  let( :warmup ) { Warmup.new }


  describe "#gets_shout" do
    it "changes input to all caps" do
      allow(warmup).to receive(:gets).and_return("good morning")
      expect(warmup.gets_shout).to eq("GOOD MORNING")
    end
    it "prints shout" do
      allow(warmup).to receive(:gets).and_return("good morning")
      expect{warmup.gets_shout}.to output(/GOOD MORNING/).to_stdout
    end
  end

  describe "#triple_size" do
    let (:array) do
      double("array", size: 3)
    end 
    it "multiples array_size by 3" do
      expect(warmup.triple_size(array)).to eq(9)
    end
  end

  describe "#calls_some_methods" do
  let(:fake_string){"hola"}
    it "string receives the upcase methods call" do
      expect(fake_string).to receive(:upcase!).and_return("HOLA")
      warmup.calls_some_methods(fake_string)
    end
    it "string receives the reverse method call" do
      expect(fake_string).to receive(:reverse!).and_return("ALOH")
      warmup.calls_some_methods(fake_string)
    end
    it 'method returns a random string' do
      expect(warmup.calls_some_methods(fake_string)).to eq("I am unrelated")
    end   
  end
end