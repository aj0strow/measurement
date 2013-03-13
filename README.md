# Measurement

Measurement is a tool to help you convert between units of measurement. It doesn't come with any predefined conversion rates. Instead, you add desired units and provide minimal equivalency statements. 

![](https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-snc7/481655_10151555899647269_1488239205_n.jpg)

#### Add units of interest

```
Measurement.add_unit(:yard, symbol: 'yd')
Measurement.add_unit('feet', symbol: :ft)
Measurement.add_unit(:inches, symbol: :in)
```

If you don't provide a symbol, it will default to the whole name of the unit. 

#### Establish equivalencies (each unit must only be connected once)

```
Measurement.add_equivalents yard: 1, feet: 3
Measurement.add_eqs foot: 1, inches: 12
```

Note: `Measurement::add_equivalents` and `Measurement::add_eqs` are aliases. 

#### The measurement class

Conversions are done through `Measurement` instances. Instances have an amount, and a unit of measurement. Only the symbol of the unit is saved in the instance itself. 

```
# Measure.new( amount, unit )
measure = Measurement.new 5, :feet
measure.amount  # or alias measure.value
# => 5 
measure.unit   
# => :foot
measure.unit_symbol
# => 'ft'
```

#### Take down some measurements and convert them!

```
puts Measurement.new(2, :yards).in('inches')
# => 72.0 inches
```

`WAIT!!! We never connected yards to inches!` 

How the gem workds is it follows a Breadth First Search pattern, saving intermediate conversion rates as it goes. It basically calulates the conversion rates on-the-fly, based on initial values. We could have put it all in one equivalency statement (see underneath), but larger statements are more error-prone.

```
Measurement.add_eqs yard: 1, feet: 3, inches: 36
```

#### Numeric methods

I gave Measurement a selection of the Numeric module methods. The most-used ones will all be there like `floor`, `ciel`, `round`, `abs` etc...

```
puts Measurement.new(6, 'in').to(:foot).ceil
# => 1 foot
```

```
puts Measurement.new(4.32, :ft).convert_to('yds')
# => 1.44 yards
```

`#in`, `#to`, and `#convert_to` are all aliased as well. 

All of the following are interchangeable in method calls and constructors: `:yards, :yard, :yds, :yd, 'yards', 'yard', 'yds', 'yd'`. \*\*\* Except in `Measurement::add_unit` \*\*\* And no, milliseconds 'ms' will not be confused with meters 'm'. 

#### Parse measurements in strings

```
Measurement.add_unit(:meters, symbol: 'm')

puts Measurement.parse('5m')
# => 5.0 meters

puts Measurement.parse('-.3 m').abs
# => 0.3 meters

puts Measurement.parse('-1.0 meters').truncate
# => -1 meter

puts -Measurement.parse('-5e-2 meter')
# => 0.05 meters
```

#### Funny symbols

Tested with µ and å, and should be fully fully compatible with all utf-8 characters that are considered letters.

```
Measurement.add_unit(:micrometer, symbol: 'µm')
Measurement.add_unit(:angstrom, symbol: 'å')

Measurement.add_eqs 'µm' => 1, 'å' => 1e4

puts Measurement.parse(' 5e6 å ').to('µm').to_s(:symbol)
# => 500.0 µm
```

#### Specify a precision

You can choose a decimal place precision to round to after each conversion. 

```
Measurement.precision = 3   # amount.round(3) after each conversion
```

#### Get prefixes for free

You can specify a range, set, or array of the powers of ten you'd like prefixes for, or pass in true to the `:prefix` option to get them all. The prefixes are for 10 ^ -24 to 10 ^ 24.

```
Measurement.add_unit(:second, symbol: 's', prefix: true)
puts Measurement.parse('0.085 ms').in('ns')
# => 85000.0 nanoseconds

Measurement.add_unit(:bit, symbol: 'b')
Measurement.add_unit(:byte, symbol: 'B', prefix: 3..24)
Measurement.add_eqs byte: 1, bits: 8

puts Measurement.parse('3.2 MB').in('bits')
# => 25600000.0 bits

puts Measurement.parse('5B').to('nB')
# => (nil)
```

----

For more check out the demos in the demos folder (supposed to be minimal.) The classes are in `lib/measurement` and tests are in `test/measurement_test`. 

## Installation

Add it to your `Gemfile`

```
gem 'measurement', github: 'aj0strow/measurement'
```

Alternatively clone the repository and require `lib/measurement`

## Contributing

Mostly looking for tips about irregular inflections such as `foot` and `feet` among measurements. 

Some ideas for the future:

- SI units - if you pass in `si: true` when adding a unit, you get every prefix for free
- Allowing closed scopes for units instead of the current "one large conversion graph" with separate clusters 
- Method to convert to the appropriate SI unit within the scope
- Derived units and proper unit cancellation with operations