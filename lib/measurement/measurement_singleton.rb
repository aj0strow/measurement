class Measurement
  
  REGEX = /([0-9eE.-]*\d)\s*([[:alpha:]]+)\W*$/
  
  @units_table = {}
  @symbols_table = {}
  @conversion_rates = {}
  
  class << self
    
    attr_reader :units_table, :symbols_table, :conversion_rates
    attr_accessor :precision
    
    def singularize(unit_key)
      unit_key.to_s.singularize.to_sym
    end
    
    def unitize(input)
      input = input.to_s
      unit = symbols_table[input] || symbols_table[input.singularize]
      unit ? unit.name : singularize(input)
    end
    
    def parse(str)
      match = str.match(REGEX)
      if match
        value, name = match.captures
        Measurement.new(value.to_f, unitize(name))
      end
    end
    
    def units
      units_table.keys
    end
    
    def add_unit(name, params = {})
      name = singularize(name)
      conversion_rates[name] ||= {}
      
      unit = Unit.new name, params
      
      units_table[name] ||= unit
      symbols_table[unit.symbol] ||= unit
    end
    
    def get_unit(name)
      units_table[ unitize(name) ]
    end
    
    alias_method :[], :get_unit
    
    def remove_unit(name)
      name = unitize(name)
      conversion_rates.delete(name)
      conversion_rates.each_value { |hash| hash.delete(name) }
      unit = units_table.delete(name)
      symbols_table.delete(unit.symbol)
    end
    
    def add_equivalents(ratios)
      rates = {}
      ratios.each do |key, value|
        rates[ unitize(key) ] = value
      end
      rates.keys.permutation(2).each do |from, to|
        conversion_rates[from][to] = rates[to].to_f / rates[from]
      end
    end
    
    alias_method :add_eqs, :add_equivalents
    
    def conversion_rate_between(a, b)
      if conversion_rates[a]
        conversion_rates[a][b] ||= bfs_calculate_rate_between(a, b)
      end
    end
    
    
    
    private
    
    
    
    def bfs_calculate_rate_between(a, b)
      visiteds = Set.new( conversion_rates[a].keys )
      nexts = []
      
      visiteds.each do |adj|
        conversion_rates[adj].keys.each do |test|
          nexts.push [ adj, test ] unless visiteds.include?(test)
        end
      end

      until conversion_rates[a][b] or nexts.empty?
        adj, test = nexts.pop
        visiteds.add test
        
        conversion_rates[a][test] = conversion_rates[a][adj] * conversion_rates[adj][test]
        
        conversion_rates[test].keys.each do |next_test|
          nexts.push [ test, next_test ] unless visiteds.include?(next_test)
        end
      end
      
      conversion_rates[a][b]
    end
        
  end
  
end