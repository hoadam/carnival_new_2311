require 'spec_helper'

RSpec.describe Ride do
  let(:ride1) { Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle }) }
  let(:ride2) { Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle }) }
  let(:ride3) { Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling }) }

  let(:visitor1) { Visitor.new('Bruce', 54, '$10') }
  let(:visitor2) { Visitor.new('Tucker', 36, '$5') }
  let(:visitor3) { Visitor.new('Penny', 64, '$15') }

  describe '#initialize' do
    it 'can initialize' do
      expect(ride1.name).to eq("Carousel")
      expect(ride1.min_height).to eq(24)
      expect(ride1.admission_fee).to eq(1)
      expect(ride1.excitement).to eq(:gentle)
      expect(ride1.total_revenue).to eq(0)
    end
  end

  describe '#board_rider' do
    it 'adds rider to rider log and deducts the spending money' do
      visitor1.add_preferences(:gentle)
      visitor2.add_preferences(:gentle)
      ride1.board_rider(visitor1)
      ride1.board_rider(visitor2)
      ride1.board_rider(visitor1)

      expect(ride1.rider_log).to eq({visitor1 =>2, visitor2 =>1})
      expect(visitor1.spending_money).to eq(8)
      expect(visitor2.spending_money).to eq(4)
    end
  end

  describe '#eligible?' do
    it 'returns false if the visitors are not tall enough' do
      expect(ride3.eligible?(visitor2)).to eq(false)
    end

    it 'returns false if the visitors do not have a matching preferences' do
      visitor1.add_preferences(:gentle)
      expect(ride3.eligible?(visitor1)).to eq(false)
    end

    it 'returns true if the visitors have enough spending money' do
      expect(ride1.eligible?(visitor1)).to eq(true)
    end
  end

  describe '#deduct_spending_money' do
    it 'deducts spending money when visitors board a ride' do
      ride1.board_rider(visitor2)
      expect(visitor2.spending_money).to eq(4)
    end
  end

  describe '#total_revenue' do
    it 'calculates the total revenue of the ride' do
      ride1.board_rider(visitor1)
      ride1.board_rider(visitor2)
      ride1.board_rider(visitor1)

      expect(ride1.total_revenue).to eq(3)
    end
  end
end
