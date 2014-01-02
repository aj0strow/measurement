require 'measurement'

Measurement.unit :meter, symbol: 'm', prefix: true

measurements = [
  Measurement.new(1, :nanometer),
  Measurement.new(3, :centimeters),
  Measurement.new(2, :kilometers)
]

puts measurements.sort
#  1 nanometer
#  3 centimeters
#  2 kilometers
