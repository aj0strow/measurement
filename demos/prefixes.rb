require_relative File.join('..', 'lib', 'measurement')

Measurement.add_unit(:meter, symbol: 'm', prefix: true)
puts Measurement.parse('0.085 mm').in('nm')
# => 85000.0 nanometers

Measurement.add_unit(:bit, symbol: 'b')
Measurement.add_unit(:byte, symbol: 'B', prefix: 3..24)
Measurement.add_eqs byte: 1, bits: 8

puts Measurement.parse('3.2 MB').in('bits')
# => 25600000.0 bits

puts Measurement.parse('5B').to('nB')
# => (nil)