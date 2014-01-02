# coding: utf-8

module Measurement
  class Unit
    attr_reader :name
    
    def initialize name, options = nil
      @name = name
      set options unless options.nil?
    end
    
    def set options
      @symbol = options[:symbol].to_s.singularize if options.include? :symbol
      @si = options[:si] if options.include? :si
    end
    
    def symbol
      @symbol || name
    end    
    
    def si?
      !!@si
    end
    
    def pluralize amount = 0
      amount == 1 ? name : name.pluralize
    end
    
    def titleize amount = 0
      pluralize(amount).capitalize
    end
        
    def to_s
      name
    end
    
    def inspect
      parts = [ '#<Unit ', name ]
      parts << " (#{symbol})" if @symbol
      parts.push('>').join
    end
    
  end
end