require 'measurement'

Measurement.unit :second, symbol: 's', prefix: true

puts Measurement.eval '3 seconds / 20 milliseconds'
#  150.0 seconds

puts Measurement.eval '1s == 1e9ns'
#  true