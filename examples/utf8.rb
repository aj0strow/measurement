# coding: utf-8

require 'measurement'

Measurement.define do
  unit :micrometer, symbol: 'µm'
  unit :angstrom, symbol: 'å'
  eqs 'µm' => 1, 'å' => 1e4
end

puts Measurement.parse(' 5e6 å ').to('µm').to_s(:symbol)
# => 500.0 µm
