class Visitor
  attr_reader :name,
              :height,
              :preferences
  attr_accessor :spending_money

  def initialize(name,height,spending_money)
    @name = name
    @height = height
    @spending_money = spending_money[1..].to_i
    @preferences = []
  end

  def add_preferences(preference)
    @preferences << preference
  end

  def tall_enough?(min_height)
    @height >= min_height
  end
end
