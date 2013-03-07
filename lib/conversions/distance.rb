class Distance
  
  @precision = 5
  
  
  
  class << self
    
    attr_accessor :precision
    
  end
  
  class Unit
    
    def initialize(symbol, singular, plural = singluar + 's', si_unit)
      @symbol = symbol
    end
    
  end
  
end