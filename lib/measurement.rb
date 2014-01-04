# coding: utf-8

Dir.glob(File.join File.dirname(__FILE__), 'measurement/*.rb') { |f| require f }

module Measurement
  @precision = nil
  attr_accessor :precision
  
  @_units, @_symbols, @_rates = {}, {}, {}
  attr_reader :_units, :_symbols, :_rates
  
  def new *args
    Base.new *args
  end
  
  def units
    _units.values
  end
    
  def remove unit
    _units.delete unit.name
    _symbols.delete unit.symbol
    _rates.delete unit
    _rates.each_value do |rates|
      rates.delete unit
    end
  end
    
  def round value
    precision.nil? ? value : value.round(precision)  
  end
  
  REGEX = /([\deE.-]*\d)\s*([[:alpha:]]+)\b(?![-\d])/
    
  def parse string
    match = string.match REGEX
    if match
      value, name = match.captures
      Base.new value.to_f, unitize(name)
    end
  end
  
  def eval string
    statement = string.gsub REGEX, 'Measurement.new(\1, "\2")'
    Kernel.eval statement
  end
  
  extend self
  extend Conversions
  extend DSL
end