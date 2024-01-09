require 'spec_helper'

RSpec.describe Carnival do
  let(:carnival) { Carnival.new(14) }
  let(:ride1) { Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle }) }
  let(:ride2) { Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle }) }
  let(:ride3) { Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling }) }
  let(:visitor1) { Visitor.new('Bruce', 54, '$10') }
  let(:visitor2) { Visitor.new('Tucker', 36, '$5') }
  let(:visitor3) { Visitor.new('Penny', 64, '$15') }

  describe '#initialize' do
    it 'can initialize' do
      expect(carnival.duration).to eq(14)
      expect(carnival.rides).to eq([])
    end
  end

  describe '#add_ride' do
    it 'adds ride to the carnival' do
      carnival.add_ride(ride1)
      carnival.add_ride(ride2)
      carnival.add_ride(ride3)

      expect(carnival.rides).to eq([ride1, ride2, ride3])
    end
  end

  describe '#most_popular_ride' do
    it 'returns the ride that has been riden the most by all visitors' do
      carnival.add_ride(ride1)
      carnival.add_ride(ride2)
      carnival.add_ride(ride3)

      visitor1.add_preferences(:gentle)
      visitor2.add_preferences(:gentle)
      visitor3.add_preferences(:thrilling)
      visitor2.add_preferences(:thrilling)

      ride1.board_rider(visitor1)
      ride1.board_rider(visitor2)
      ride1.board_rider(visitor1)
      ride3.board_rider(visitor3)

      expect(carnival.most_popular_ride).to eq(ride1)
    end
  end

  describe '#most_popular_ride' do
    it 'returns the ride that has been riden the most by all visitors' do
      carnival.add_ride(ride1)
      carnival.add_ride(ride2)
      carnival.add_ride(ride3)

      visitor1.add_preferences(:gentle)
      visitor2.add_preferences(:gentle)
      visitor3.add_preferences(:thrilling)
      visitor2.add_preferences(:thrilling)

      ride1.board_rider(visitor1)
      ride1.board_rider(visitor1)
      ride2.board_rider(visitor2)
      ride3.board_rider(visitor3)

      expect(carnival.most_profitable_ride).to eq(ride2)
    end
  end

  describe '#total_revenue' do
    it 'calculates the total revenues earned from all its rides' do
      carnival.add_ride(ride1)
      carnival.add_ride(ride2)
      carnival.add_ride(ride3)

      visitor1.add_preferences(:gentle)
      visitor2.add_preferences(:gentle)
      visitor3.add_preferences(:thrilling)
      visitor2.add_preferences(:thrilling)

      ride1.board_rider(visitor1)
      ride1.board_rider(visitor1)
      ride2.board_rider(visitor2)
      ride3.board_rider(visitor3)

      expect(carnival.total_revenue).to eq(9)
    end
  end

  describe '#summary' do
    it 'provides a summary hash' do
      carnival.add_ride(ride1)
      carnival.add_ride(ride2)
      carnival.add_ride(ride3)

      visitor1.add_preferences(:gentle)
      visitor2.add_preferences(:gentle)
      visitor3.add_preferences(:gentle)
      visitor3.add_preferences(:thrilling)
      visitor2.add_preferences(:thrilling)

      ride1.board_rider(visitor1)
      ride1.board_rider(visitor1)
      ride2.board_rider(visitor2)
      ride2.board_rider(visitor3)
      ride3.board_rider(visitor3)

      expect(carnival.summary).to eq({
        visitor_count: 3,
        revenue_earned: 14,
        visitors: [
          {
            visitor: visitor1,
            favorite_ride: ride1,
            total_money_spent: 2
          },
          {
            visitor: visitor2,
            favorite_ride: ride2,
            total_money_spent: 5
          },
          {
            visitor: visitor3,
            favorite_ride: ride2,
            total_money_spent: 7
          }
        ],
        rides: [
          {
            ride: ride1,
            riders: [visitor1],
            total_revenue: 2
          },
          {
            ride: ride2,
            riders: [visitor2, visitor3],
            total_revenue: 10
          },
          {
            ride: ride3,
            riders: [visitor3],
            total_revenue: 2
          }
        ]
      })
    end
  end

  describe '#visitor_count' do
    it 'counts the total visitors in each carnival' do
      carnival.add_ride(ride1)
      carnival.add_ride(ride2)
      carnival.add_ride(ride3)

      visitor1.add_preferences(:gentle)
      visitor2.add_preferences(:gentle)
      visitor3.add_preferences(:thrilling)
      visitor2.add_preferences(:thrilling)

      ride1.board_rider(visitor1)
      ride1.board_rider(visitor1)
      ride2.board_rider(visitor2)
      ride2.board_rider(visitor3)
      ride3.board_rider(visitor3)

      expect(carnival.visitor_count).to eq(3)
    end
  end

  describe '#revenue_earned' do
    it 'returns the total revenue earned' do
      carnival.add_ride(ride1)
      carnival.add_ride(ride2)
      carnival.add_ride(ride3)

      visitor1.add_preferences(:gentle)
      visitor2.add_preferences(:gentle)
      visitor3.add_preferences(:thrilling)
      visitor2.add_preferences(:thrilling)

      ride1.board_rider(visitor1)
      ride1.board_rider(visitor1)
      ride2.board_rider(visitor2)
      ride2.board_rider(visitor3)
      ride3.board_rider(visitor3)

      expect(carnival.revenue_earned).to eq(14)
    end

  end
end
