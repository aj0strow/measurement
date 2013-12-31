# coding: utf-8

class Measurement
  class Base
    
    def initialize(amount, unit)
      self.amount = amount
      self.unit = self.class.unitize unit
    end
    
    attr_reader :amount, :unit
    alias_method :value, :amount
    
    def convert_to(new_unit)
      new_unit = unitize new_unit
      ratio = self.class.conversion_rate_between unit, new_unit
      if ratio
        new_amount = amount * ratio
        new_amount = new_amount.round(self.class.precision) if self.class.precision
      end
    end
    alias_method :to, :convert_to
    alias_method :in, :convert_to
    
    def convert_to!(new_unit)
      converted = convert_to new_unit
      unless converted
        raise ArgumentError, "can't convert from #{unit} to #{new_unit}"
      end
    end
    alias_method :to!, :convert_to!
    alias_method :in!, :convert_to!
    
    def to_s(flag = :name)
      case flag
      when :name
        "#{amount} #{pluralized_unit}"
      when :title
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
    
    def unit_symbol
      Measurement[unit].symbol
    end
    
    
    private
    
    
    def pluralized_unit
      name = unit.to_s
      amount.abs == 1 ? name : name.pluralize
    end
    
    def unitize(str)
      self.class.unitize str
    end
    
  end
end