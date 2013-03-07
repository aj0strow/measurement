class Conversions
  class SI
    
    class Prefix
  
      @names = {}
      @symbols = {}
      @powers = {}
      
      attr_accessor :name, :symbol, :power
      
      def initialize(name, symbol, power)
        @name, @symbol, @power = name, symbol, power
      end
      
      def multiplier
        (power >= 0) ? (10 ** power) : (1 / 10 ** (-power))
      end
      
      class << self
    
        attr_accessor :names, :symbols, :powers
        
        def add(name, symbol, power)
          prefix = Prefix.new(name, symbol, power)
          @names[name] = prefix
          @symbols[symbol] = prefix
          @powers[power] = prefix
        end
                
        %w( name symbol power ).permutation(2).each do |into, out|
          define_method("#{into}_to_#{out}") do |param|
            prefix = self.send("#{into}s")[param]
            prefix and prefix.send(out)
          end
        end
        
      end
      
      
    end
    
  end
end