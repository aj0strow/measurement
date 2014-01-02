require_relative File.join('..', 'lib', 'measurement')

Measurement.unit(:meter, symbol: 'm', prefix: true)
puts Measurement.parse('0.085 mm').in('nm')
# => 85000.0 nanometers

Measurement.unit(:bit, symbol: 'b')
Measurement.unit(:byte, symbol: 'B', prefix: 3..24)
Measurement.eqs byte: 1, bits: 8

puts Measurement.parse('3.2 MB').in('bits')
# => 25600000.0 bits

puts Measurement.parse('5B').to('nB')
# => (nil)