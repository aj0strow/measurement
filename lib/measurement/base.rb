# coding: utf-8

module Measurement
  class Base
    attr_accessor :amount, :unit
    alias_method :value, :amount
    
    def initialize(amount, unit)
      self.amount = amount
      self.unit = Measurement[unit]
    end
    
    def convert_to(new_unit)
      new_unit = Measurement[new_unit]
      ratio = Measurement.conversion_rate_between unit, new_unit
      if ratio
        new_amount = Measurement.round amount * ratio
        self.class.new(new_amount, new_unit)
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
        "#{amount} #{unit.pluralize(amount)}"
      when :title
        "#{amount} #{unit.titleize(amount)}"
      when :symbol
        "#{amount} #{unit.symbol}"
      when :short
        "#{amount}#{unit.symbol}"
      end
    end

    def inspect
      "#<Measurement #{amount} #{unit.inspect}>"
    end
    
    %w(+@ -@ ceil conj conjugate floor abs magnitude round truncate real modulo divmod div).each do |action|
      define_method action do |*args|
        new_amount = amount.send action, *args
        self.class.new new_amount, unit
      end
    end
    
    %w(zero? to_i to_int to_f to_r to_c real? nonzero? integer?).each do |action|
      define_method action do |*args|
        amount.send action, *args
      end
    end  
    
  end
end