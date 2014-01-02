# Measurement ![](https://travis-ci.org/aj0strow/measurement.png)

> Unit conversions for humans! Add desired units and declare minimum equivalency statements. 

![](https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-snc7/481655_10151555899647269_1488239205_n.jpg)

#### Choose Units

```ruby
Measurement.unit :yard, symbol: 'yd'

Measurement.define do
  unit 'feet', symbol: :ft
  unit :inches, symbol: :in
end
```

The symbol defaults to the whole name of the unit. 

#### Establish Equivalencies

Each unit must only be connected once. 

```ruby
Measurement.eqs yard: 1, feet: 3

Measurement.define do
  equivalents foot: 1, inches: 12
end
```

Note: `Measurement::equivalents` and `Measurement::eqs` are aliases. 

#### Create Measurements

Conversions are done through `Measurement::Base` instances. Instances have an amount, and a unit (`Measurement::Unit`).

```ruby
height = Measurement.new 6, :feet
# => 6 feet

height.amount  # alias: height.value
# => 6

height.unit   
# => foot

height.unit.symbol
# => "ft"
```

#### Conversions!

```ruby
Measurement.new(2, :yards).in('inches')
# => 72.0 inches
```

> WAIT!!! We never connected yards to inches!` 

`Measurement` follows a Breadth First Search pattern, saving intermediate conversion rates as it goes. It calulates the conversion rates on-the-fly, based on initial values. We could have put it all in one equivalency statement (see underneath), but larger statements are more error-prone. 

```ruby
Measurement.eqs yard: 1, feet: 3, inches: 36
```

#### Math

All operations are supported. Measurements with different units are handled correctly. 

```ruby
Measurement.new(3, :feet) + Measurement.new(6, :inches)
# => 3.5 feet

Measurement.new(3, :feet) / 3
# => 1 foot
```

#### Numeric Methods

Measurements have a selection of Numeric module methods. The most-used ones will be there such as `floor`, `ciel`, `round`, `abs` etc...

```ruby
Measurement.new(6, 'in').to(:foot).ceil
# => 1 foot
```

```ruby
Measurement.new(4.32, :ft).in('yds')
# => 1.44 yards
```

Note: `#in` and `#to` are aliases.

All of the following are interchangeable in method calls and constructors: `:yards, :yard, :yds, :yd, 'yards', 'yard', 'yds', 'yd'`. \*\*\* Except in `Measurement::unit` definitions. \*\*\* And no, milliseconds 'ms' will never be confused with meters 'm'. 

#### Parse Measurement Strings

```ruby
Measurement.unit(:meters, symbol: 'm')

Measurement.parse('5m')
# => 5.0 meters

Measurement.parse('-.3 m').abs
# => 0.3 meters

Measurement.parse('-1.0 meters').truncate
# => -1 meter

- Measurement.parse('-5e-2 meter')
# => 0.05 meters
```

#### Funny Symbols

Tested with µ and å, and should be fully compatible with all utf-8 characters that are considered letters.

```ruby
Measurement.define do
  unit :micrometer, symbol: 'µm'
  unit :angstrom, symbol: 'å'
  
  eqs 'µm' => 1, 'å' => 1e4
end

Measurement.parse(' 5e6 å ').to('µm').to_s(:symbol)
# => 500.0 µm
```

#### Specify Global Precision

You may choose a decimal place precision to round to after each conversion. 

```ruby
Measurement.precision = 3   # round(3) after each conversion
```

#### Magnitude Prefixes

You may specify a range, set, or array of the powers of ten you'd like prefixes for, or pass in true to the `:prefix` option to get them all. SI prefixes are for 10 ^ -24 to 10 ^ 24.

```ruby
Measurement.unit :second, symbol: 's', prefix: true
Measurement.parse('0.085 ms').in('ns')
# => 85000.0 nanoseconds

Measurement.define do
  unit :bit, symbol: 'b'
  unit :byte, symbol: 'B', prefix: 3..24
  eqs byte: 1, bits: 8
end

Measurement.parse('3.2 MB').in('bits')
# => 25600000.0 bits

Measurement.parse('5B').to('nB')
# => (nil)
```

----

Check the examples folder for minimal stand-alone examples of functionality. Code is in `lib/measurement` and tests are in `test/measurement_test`. 

## Installation

Add measurement to your `Gemfile`:

```
gem 'measurement', github: 'aj0strow/measurement'
```

And then require it:

```ruby
require 'measurement'
```

## Contributing

Mostly looking for tips about irregular inflections such as `foot` and `feet` among measurement names and symbols. 

Some ideas for the future:

- Method to convert to an available SI unit
- Derived units and proper unit cancellation with operations