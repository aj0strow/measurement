require 'test_helper'

class MeasurementSingletonTest < Test::Unit::TestCase
  
  test 'Mesurement unitizes' do
    [ 'dog', 'dogs', :dog, :dogs ].each do |input|
      assert_equal :dog, Measurement.unitize(input)
    end
  end
  
  test 'Measurement::units returns array' do
    assert_equal Measurement.units.clear, []
  end
  
  test 'Measurement::add_unit adds to the units_table' do
    unit = Measurement.add_unit :mile, symbol: 'mi'
    assert_equal unit, Measurement.units_table[:mile]
  end
  
  test 'units are only added once' do
    Measurement.add_unit :light_year
    Measurement.add_unit :light_year, symbol: 'ly'
    assert_not_equal Measurement.units_table[:light_year].symbol, 'ly'
  end
  
  test 'unit added with rates hash' do
    Measurement.add_unit(:pink_elephant)
    assert_equal Measurement.conversion_rates[:pink_elephant], {}
  end
  
  test 'units can be accessed with []' do
    inch = Measurement.add_unit(:inch)
    assert_equal inch, Measurement.get_unit(:inch)
    assert_equal inch, Measurement[:inch]
  end
  
  test 'converting units returns nil if not possible' do
    rate = Measurement.conversion_rate_between(:apples, :oranges)
    assert_nil rate
  end
  
  test 'Measurement::add_conversion_rates does a permutation' do
    [ :whole, :half, :quarter ].each { |unit| Measurement.add_unit(unit) }
    
    Measurement.add_equivalents whole: 1, half: 2, quarter: 4
    
    assert_equal 2, Measurement.conversion_rate_between(:whole, :half)
    assert_equal 4, Measurement.conversion_rate_between(:whole, :quarter)
    
    assert_equal 0.5, Measurement.conversion_rate_between(:half, :whole)
    assert_equal 2, Measurement.conversion_rate_between(:half, :quarter)
    
    assert_equal 0.25, Measurement.conversion_rate_between(:quarter, :whole)
    assert_equal 0.5, Measurement.conversion_rate_between(:quarter, :half)
  end


  
  teardown do
    remove_all_units
  end
  
end