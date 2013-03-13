class Measurement
  PREFIXES ||= {}
end

if Measurement::PREFIXES.empty?
  
  data_file = File.join File.dirname(__FILE__), '..', 'data', 'prefixes.txt'
  prefixes = IO.read(data_file).each_line do |line|
    name, symbol, power = line.split
    
    prefix_record = { 
      name: name, 
      symbol: symbol, 
      power: power.to_i 
    }
  
    Measurement::PREFIXES[symbol] = prefix_record
  end
  
  
end
