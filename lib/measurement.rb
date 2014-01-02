# coding: utf-8

Dir.glob(File.join File.dirname(__FILE__), 'measurement/*.rb') { |f| require f }

module Measurement
  @_units = {}
  @_symbols = {}
  @_rates = {}
  @precision = nil
  
  attr_accessor :precision
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
    
  REGEX = /([0-9eE.-]*\d)\s*([[:alpha:]]+)\W*$/
    
  def parse(string)
    match = string.match REGEX
    if match
      value, name = match.captures
      Base.new value.to_f, name
    end
  end
  
  extend self
  extend Conversions
  extend DSL
end