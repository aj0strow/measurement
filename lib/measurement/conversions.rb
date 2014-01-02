require 'set'

module Measurement
  module Conversions    
    # rates = { unit => numeric, unit => numeric, etc }
    def conversions rates
      rates.keys.permutation(2) do |from, to|
        _rates[from] ||= {}
        _rates[from][to] = rates[to].to_f / rates[from]
      end
    end
    
    def conversion_rate_between from, to
      from, to = [ from, to ].map { |unit| unitize unit }
      if _rates[from]
        _rates[from][to] ||= bfs_conversion_rate_between from, to
      end
    end
    
    
    private

    
    def bfs_conversion_rate_between from, to
      from, to = [ from, to ].map { |unit| unitize unit }
      
      visiteds = Set.new _rates[from].keys << from
      nexts = Queue.new
      
      _rates[from].keys.each do |first|
        _rates[first].keys.each do |second|
          nexts << [ first, second ] unless visiteds.include? second
        end
      end
      
      until _rates[from][to] or nexts.empty?
        first, second = nexts.pop
        visiteds.add second
        
        _rates[from][second] = _rates[from][first] * _rates[first][second]
        
        _rates[second].keys.each do |third|
          nexts << [ second, third ] unless visiteds.include? third
        end
      end
      
      _rates[from][to]
    end
    
  end
end