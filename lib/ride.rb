require './lib/visitor'
class Ride
  attr_reader :name,
              :min_height,
              :admission_fee,
              :excitement,
              :rider_log,
              :total_revenue

  def initialize(attributes)
    @name = attributes[:name]
    @min_height = attributes[:min_height]
    @admission_fee = attributes[:admission_fee]
    @excitement = attributes[:excitement]
    @rider_log = Hash.new(0)
  end

  def board_rider(visitor)
    return if !eligible?(visitor)
    @rider_log[visitor] += 1
    deduct_spending_money(visitor)
  end

  def eligible?(visitor)
    visitor.tall_enough?(@min_height) &&
    (visitor.preferences.include?(@excitement) || visitor.preferences.empty?) &&
    visitor.spending_money >= @admission_fee
  end

  def deduct_spending_money(visitor)
    visitor.spending_money -= @admission_fee
  end

  def total_revenue
    @admission_fee * @rider_log.values.sum
  end
end
