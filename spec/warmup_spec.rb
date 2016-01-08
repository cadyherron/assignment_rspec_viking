require 'warmup'

describe Warmup do


  let( :warmup ) { Warmup.new }


  describe "#gets_shout" do
    it "changes input to all caps" do
      allow(warmup).to receive(:gets) and return("good morning")
      expect(warmup.gets_shout).to eq("GOOD MORNING")
    end


  end



end