require './lib/visitor'
require './lib/ride'

class Carnival
  attr_reader :duration,
              :rides,
              :summary

  def initialize(duration)
    @duration = duration
    @rides = []
    @summary = {}
  end

  def add_ride(ride)
    @rides << ride
  end

  def most_popular_ride
    @rides.max_by do |ride|
      ride.rider_log.values.sum
    end
  end

  def most_profitable_ride
    @rides.max_by do |ride|
      ride.total_revenue
    end
  end

  def total_revenue
    @rides.sum do |ride|
      ride.total_revenue
    end
  end



  def visitor_count
    total_visitors = @rides.flat_map { |ride| ride.rider_log.keys }
    total_visitors.uniq.length
  end

  def revenue_earned
    @rides.sum do |ride|
      ride.total_revenue
    end
  end
end
