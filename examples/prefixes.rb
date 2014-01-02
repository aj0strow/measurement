require 'measurement'

Measurement.unit(:meter, symbol: 'm', prefix: true)

puts Measurement.parse('0.085 mm').in('nm')
#  85000.0 nanometers

Measurement.define do
  unit :bit, symbol: 'b'
  unit :byte, symbol: 'B', prefix: 3..24
  eqs byte: 1, bits: 8
end

puts Measurement.parse('3.2 MB').in('bits')
#  25600000.0 bits

puts Measurement.parse('5B').to('nB')
#  (nil)