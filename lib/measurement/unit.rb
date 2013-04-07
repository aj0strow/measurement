# encoding: utf-8

class Measurement
  class Unit
    
    attr_reader :name
    
    def initialize(name, params = {})
      @name = Measurement.singularize(name)
      @symbol = params[:symbol].to_s if params[:symbol]
      @si = !!params[:si]
    end
    
    def symbol
      @symbol || name.to_s
    end
    
    def si_unit?
      @si
    end
    
    alias_method :si?, :si_unit?
    
    def to_s
      name.to_s
    end
    
    def inspect
      parts = [ name.inspect ]
      parts.push "'#{@symbol}'" if @symbol
      parts.push "si=true" if si_unit?
      "#<Unit #{ parts.join(' ') }>"
    end
    
  end
end