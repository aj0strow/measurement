require_relative File.join('..', 'lib', 'measurement')

Measurement.define do
  
  # Add units of interest
  
  unit(:yard, symbol: 'yd')
  unit('feet', symbol: :ft)
  unit(:inches, symbol: :in)
  
  # Establish equivalencies 
  
  eqs yard: 1, feet: 3
  eqs foot: 1, inches: 12
  
end


# Do conversions!

puts Measurement.new(2, :yards).in('inches')
# => 72.0 inches

puts Measurement.new(6, 'in').to(:foot).ceil
# => 1 foot

puts Measurement.new(4.32, :ft).convert_to('yds')
# => 1.44 yards