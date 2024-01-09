require 'spec_helper'

RSpec.describe Visitor do
  let(:visitor1) { Visitor.new('Bruce',54,'$10') }
  let(:visitor2) { Visitor.new('Tucker', 36, '$5') }
  let(:visitor3) { Visitor.new('Penny', 64, '$15')}

  describe '#initialize' do
    it 'can initialize' do
      expect(visitor1.name).to eq('Bruce')
      expect(visitor1.height).to eq(54)
      expect(visitor1.spending_money).to eq(10)
      expect(visitor1.preferences).to eq([])
    end
  end

  describe "#add_preferences" do
    it 'adds preferences' do
      visitor1.add_preferences(:gentle)
      visitor1.add_preferences(:thrilling)

      expect(visitor1.preferences).to eq([:gentle, :thrilling])
    end
  end

  describe "#tall_enough?" do
    it 'checks visitors height if they are tall enough for rides based on a given height' do
      expect(visitor1.tall_enough?(54)).to eq(true)
      expect(visitor2.tall_enough?(54)).to eq(false)
      expect(visitor3.tall_enough?(54)).to eq(true)
      expect(visitor1.tall_enough?(64)).to eq(false)
    end
  end
end
