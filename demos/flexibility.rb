require_relative File.join('..', 'lib', 'measurement')


# Add your units of interest

Measurement.add_unit(:yard, symbol: 'yd')
Measurement.add_unit('feet', symbol: :ft)
Measurement.add_unit(:inches, symbol: :in)


# Establish equivalencies. Each unit need only be mentioned once. 

Measurement.add_eqs yard: 1, feet: 3
Measurement.add_eqs foot: 1, inches: 12


# Take down some measurements and convert them!

puts Measurement.new(2, :yards).in('inches')
# => 72.0 inches

puts Measurement.new(6, 'in').to(:foot).ceil
# => 1 foot

puts Measurement.new(4.32, :ft).convert_to('yds')
# => 1.44 yards


# Basically :yards, :yard, 'yards', 'yard', 'yds', and 'yd' can 
# all be use interchangeably. And no, milliseconds 'ms' will not
# be confused with meters 'm'.