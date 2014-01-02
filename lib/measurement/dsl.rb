module Measurement
  module DSL
    def define &block
      instance_eval &block
    end
        
    def unit name, options = {}
      unitize(name) || create(name, options)
    end
    alias_method :[], :unit
    
    def equivalents ratios
      rates = {}
      ratios.each do |name, value|
        rates[unitize name] = value
      end
      conversions rates
    end
    alias_method :eqs, :equivalents
    
    def unitize unit
      case unit
      when Unit
        unit
      else
        name = unit.to_s
        fetch name do
          fetch name.singularize, nil
        end
      end
    end
    
    
    private
    
        
    def create name, options
      name = name.to_s.singularize
      unit = Unit.new name, options
      register unit
      prefix unit, options[:prefix]
      unit
    end
    
    def register unit
      _units[unit.name] = unit
      _symbols[unit.symbol] = unit
    end
    
    def fetch name, default = nil
      _units.fetch name do
        _symbols.fetch name do
          block_given? ? yield : default
        end
      end
    end
    
    def prefix unit, range
      unless range.nil?
        prefixes = Measurement::PREFIXES.values
        if range.respond_to? :include?
          prefixes = prefixes.select do |prefix|
            range.include? prefix[:power]
          end
        end
        prefixes.each do |prefix|
          name, symbol = [ :name, :symbol ].map do |key|
            [ prefix[key], unit.send(key) ].join
          end
          prefixed = unit name, symbol: symbol
          equivalents unit => 10 ** prefix[:power], prefixed => 1
        end
      end
    end 
        
  end
end