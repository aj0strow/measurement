class Measurement
  
  def initialize(amount, unit)
    @amount = amount
    @unit = self.class.unitize(unit)
  end
  
  attr_reader :amount, :unit
  
  alias_method :value, :amount
  
  def convert_to(new_unit)
    new_unit = self.class.unitize(new_unit)
    ratio = Measurement.conversion_rate_between(unit, new_unit)
    if ratio
      new_amount = amount * ratio
      new_amount = new_amount.round(self.class.precision) if self.class.precision
      Measurement.new(new_amount, new_unit )
    end
  end
  
  alias_method :to, :convert_to
  alias_method :in, :convert_to
  
  def convert_to!(new_unit)
    converted = convert_to new_unit
    unless converted
      msg = "No conversion exists between #{unit.inspect} and #{new_unit.inspect}!"
      raise ArgumentError, msg
    end
  end
  
  alias_method :to!, :convert_to!
  alias_method :in!, :convert_to!
  
  def unit_symbol
    Measurement[unit].symbol
  end
  
  def to_s(flag = :name)
    case flag
    when :name
      "#{amount} #{pluralized_unit}"
    when :capitalized
      "#{amount} #{pluralized_unit.capitalize}"
    when :symbol
      "#{amount} #{unit_symbol}"
    when :short
      "#{amount}#{unit_symbol}"
    end
  end
  
  def inspect
    "#<Measurement #{amount} #{unit.inspect}>"
  end
  
  private
  
  def pluralized_unit
    name = unit.to_s
    amount == 1 ? name : name.pluralize
  end
  
  
  
end