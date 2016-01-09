require 'viking'
require'./lib/weapons/weapon'


describe Viking do

  let ( :viking ) { Viking.new("Olaf", 50)}
  let ( :viking_bow ) { Viking.new("Beau", 100, 10, Bow.new)}

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
      viking_bow.pick_up_weapon(Axe.new)
      expect(viking_bow.weapon).to be_an_instance_of(Axe)
    end

    it "dropping the weapon makes viking weaponless" do
      expect(viking_bow.drop_weapon).to be nil
    end
  end

  describe "#receive_attack" do

    it "reduces health of target by specified amount" do
      expect{viking.receive_attack(10)}.to change(viking, :health).by(-10)
    end

    it "calls take_damage method" do
      expect(viking).to receive(:take_damage)
      viking.receive_attack(5)
    end
  
  end

  describe "#attack" do
    it 'attacking another viking, drops their health' do
      expect{viking.attack(viking_bow)}.to change(viking_bow, :health).by(-2.5)
    end
    it 'attacking another Viking calls Viking take damage method' do
      expect(viking_bow).to receive(:take_damage)
      viking.attack(viking_bow)
    end
    it 'with no weapons, runs damages with fists' do
      expect(viking).to receive(:damage_with_fists).and_return(5)
      viking.attack(viking_bow)
    end

    it 'with no weapons, deals multiplier times strength' do
      damage = Fists.new.use*viking.strength
      expect(viking).to receive(:damage_with_fists).and_return(damage)
       viking.attack(viking_bow)
    end

    it 'with weapon, runs damage_with_weapon' do
      expect(viking_bow).to receive(:damage_with_weapon).and_return(5)
      viking_bow.attack(viking)
    end
    it 'with weapon, deals damage multiplier times strength' do
      damage = Bow.new.use*viking_bow.strength
      expect(viking_bow).to receive(:damage_with_weapon).and_return(damage)
      viking_bow.attack(viking)
    end
    it 'with Bow, with no arrows, attacks with fists' do
      10.times {viking_bow.weapon.use}
      2.times {viking_bow.attack(viking)}
      expect(viking_bow).to receive(:damage_with_fists).and_return(5)
      viking_bow.attack(viking)
    end
  end

  context 'player has died' do
    it "killing a viking raises error" do
      expect{20.times{viking_bow.attack(viking)}}.to raise_error()
    end
  end  

end