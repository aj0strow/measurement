# Measurement

Measurement is a tool to help you convert between units of measurement. It doesn't come with any predefined conversion rates. Instead, you add desired units and provide minimal equivalency statements. 

##### Add your units of interest

```
Measurement.add_unit(:yard, symbol: 'yd')
Measurement.add_unit('feet', symbol: :ft)
Measurement.add_unit(:inches, symbol: :in)
```

If you don't provide a symbol, it will default to the whole name of the unit. 

##### Establish equivalencies. Each unit need only be mentioned once. 

```
Measurement.add_equivalents yard: 1, feet: 3
Measurement.add_eqs foot: 1, inches: 12
```

Note: `::add_equivalents` and `::add_eqs` are aliased. 

##### Take down some measurements and convert them!

```
puts Measurement.new(2, :yards).in('inches')
# => 72.0 inches
```

You'll notice we never connected yards to inches directly. Instead, the gem follows a Breadth First Search pattern, saving intermediate conversion rates as it goes. Although we easily could have put it all in one equivalency statement:

```
Measurement.add_eqs yard: 1, feet: 3, inches: 36
```

The goal is to reduce errors though, so I generally stick to 1-to-1 equivalency statements. 

```
puts Measurement.new(6, 'in').to(:foot).ceil
# => 1 foot
```

```
puts Measurement.new(4.32, :ft).convert_to('yds')
# => 1.44 yards
```

`#in`, `#to`, and `#convert_to` are all aliased as well. 

All of the following are interchangeable in method calls and constructors: `:yards, :yard, :yds, :yd, 'yards', 'yard', 'yds', 'yd'`. And no, milliseconds 'ms' will not be confused with meters 'm'. \*\*\* Except in `Measurement::add_unit` \*\*\*

##### Parse measurements in strings

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

##### Funny symbols

Tested with µ and å, and should be fully fully compatible with all utf-8 characters that are considered letters.

```
Measurement.add_unit(:micrometer, symbol: 'µm')
Measurement.add_unit(:angstrom, symbol: 'å')

Measurement.add_eqs 'µm' => 1, 'å' => 1e4

puts Measurement.parse(' 5e6 å ').to('µm').to_s(:symbol)
# => 500.0 µm
```

### Installation

Add it to your `Gemfile`

```
gem 'measurement', github: 'aj0strow/measurement'
```

Alternatively clone the repository and require `lib/measurement`

### Contributing

Mostly looking for tips about irregular inflections such as `foot` and `feet` among measurements. 

Some ideas for the future:

- SI units - if you pass in `si: true` when adding a unit, you get every prefix for free
- Allowing closed scopes for units instead of the current "one large conversion graph" with separate clusters 
- Method to convert to the appropriate SI unit within the scope
- Derived units and proper unit cancellation with operations