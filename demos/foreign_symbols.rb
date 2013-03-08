# encoding: utf-8

require_relative File.join('..', 'lib', 'measurement')

Measurement.add_unit(:micrometer, symbol: 'µm')
Measurement.add_unit(:angstrom, symbol: 'å')

Measurement.add_eqs 'µm' => 1, 'å' => 1e4

puts Measurement.parse(' 5e6 å ').to('µm').to_s(:symbol)
# => 500.0 µm
