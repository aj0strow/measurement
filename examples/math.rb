require 'measurement'

Measurement.define do
  unit :second
  unit :minute
  eqs minute: 1, seconds: 60
end

three_minutes = Measurement.new(3, :minutes)
twenty_seconds = Measurement.new(20, :seconds)

puts three_minutes + twenty_seconds
# => 3.3333333333333335 minutes

puts three_minutes - twenty_seconds
# => 2.6666666666666665 minutes

puts twenty_seconds + three_minutes
# => 200.0 seconds

puts twenty_seconds * 2
# => 40 seconds

puts three_minutes / 3
# => 1 minute