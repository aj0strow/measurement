require 'measurement'

Measurement.unit(:meters, symbol: 'm')

puts Measurement.parse('5m')
# => 5.0 meters

puts Measurement.parse('-.3 m').abs
# => 0.3 meters

puts Measurement.parse('-1.0 meters').truncate
# => -1 meter

puts -Measurement.parse('-5e-2 meter')
# => 0.05 meters