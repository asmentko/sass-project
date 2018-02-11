# als we created this model from scratch, capitalized PLANS is a constant, not a variable

class Plan
  PLANS = [:free, :premium]

  def self.options
    PLANS.map { |plan| [plan.capitalize, plan] }
  end
end
