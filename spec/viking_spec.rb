require 'viking'
require'./lib/weapons/weapon'


describe Viking do

  let ( :viking ) { Viking.new("Olaf", 50)}
  let ( :viking_bow ) { Viking.new("Beau", 100, 10, "Bow")}

  describe '#initialize' do
    it "creates a viking with the name we pass it" do
      expect(viking.name).to eq("Olaf")
    end

    it "creates a viking with the health we pass it" do
      expect(viking.health).to eq(50)
    end

    it "health cannot be overwritten once it's set" do
      expect{viking.health = 75}.to raise_error(NoMethodError)
    end

    it "viking's weapon is nil by default" do
      expect(viking.weapon.nil?).to be true
    end
  end

  describe "#pick_up_weapon" do

    it "picking up a weapon set it as the viking's weapon" do
      viking.pick_up_weapon(Bow.new)
      expect(viking.weapon).to be_an_instance_of(Bow)
    end

    it "picking up a non-weapon raises an exception" do
      expect{viking.pick_up_weapon("non-weapon")}.to raise_error(RuntimeError)
    end

    it "switching weapons replaces the viking's existing weapon" do
      # viking.pick_up_weapon(Bow.new)
      # expect(viking.weapon).to be_an_instance_of(Bow)
      viking_bow.pick_up_weapon(Axe.new)
      expect(viking_bow.weapon).to be_an_instance_of(Axe)
    end

    it "dropping the weapon makes viking weaponless" do
      expect(viking_bow.drop_weapon).to be nil
    end
  end

  describe "#receive_attack" do

    it "receiving attack reduces health by specified amount" do
      expect{viking.receive_attack(10)}.to change(viking, :health).by(-10)
    end

    xit "receive_attack calls take_damage method" do
      fake = double("fake", :take_damage => -10)
      allow(viking).to receive(:take_damage).with(10)
      expect(fake).to receive(fake).with(10)
    end









  end


end