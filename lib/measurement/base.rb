# coding: utf-8

module Measurement
  class Base
    attr_accessor :amount, :unit
    alias_method :value, :amount
    
    def initialize amount, unit_name
      unit = namespace.unitize unit_name
      raise ArgumentError, "no unit `#{unit_name.inspect}`" if unit.nil?
      
      @amount, @unit = amount, unit
    end
    
    def to new_unit
      new_unit = namespace.unitize new_unit
      if unit == new_unit
        new amount, unit
      elsif (rate = namespace.conversion_rate_between unit, new_unit)
        new_amount = namespace.round rate * amount
        new new_amount, new_unit
      end
    end
    alias_method :in, :to
    
    def to! new_unit
      to(new_unit).tap do |measurement|
        if measurement.nil?
          raise ArgumentError, "can't convert from #{unit} to #{new_unit}"
        end
      end
    end
    alias_method :in!, :to!
    
    def to_s flag = :name
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
    
    %w(+@ -@ % ceil conj conjugate floor abs magnitude round truncate real modulo divmod div).each do |action|
      define_method action do |*args|
        new_amount = amount.send action, *args
        new new_amount, unit
      end
    end
        
    %w(zero? to_i to_int to_f to_r to_c real? nonzero? integer?).each do |action|
      define_method action do |*args|
        amount.send action, *args
      end
    end
    
    %w(+ - * /).each do |op|
      define_method op do |measurement|
        new_amount = amount.send op, measurement.to!(unit).amount
        new new_amount, unit
      end
    end
    
    
    private
    
    
    def new *args
      send(:class).new *args
    end
    
    def namespace
      Measurement
    end
    
  end
end