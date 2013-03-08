require 'test_helper'

class MeasurementInstanceTest < Test::Unit::TestCase
  
  setup do
    Measurement.add_unit(:meter, symbol: 'm', si: true)
    Measurement.add_unit(:foot, symbol: 'ft')
    Measurement.add_unit(:yard, symbol: 'yd')
    Measurement.add_unit(:fathom, symbol: 'ftm')
    
    Measurement.add_equivalents yard: 1, foot: 3
    Measurement.add_equivalents meter: 1, foot: 3.28084
    Measurement.add_equivalents fathom: 1, meter: 1.8288
  end
  
  
    
  test 'new measurement' do
    ruler = Measurement.new(1, :foot)
    assert_equal 1, ruler.amount
    assert_equal :foot, ruler.unit
  end
  
  test 'value aliased to amount' do
    ruler = Measurement.new(1, :foot)
    assert_equal ruler.amount, ruler.value
  end
  
  test 'new measurement with string unit' do
    assert_equal :foot, Measurement.new(1, 'foot').unit
  end
  
  test 'new measurement with plural unit' do
    assert_equal :foot, Measurement.new(3, 'feet').unit
    assert_equal :foot, Measurement.new(3, :feet).unit
  end
  
  test 'measurement inspect' do
    assert_equal "#<Measurement 5 :newton>", Measurement.new(5, :newton).inspect
  end
  
  test 'measurement can get unit symbol' do
    yard_stick = Measurement.new(3, 'yards')
    assert_equal :yard, yard_stick.unit
    assert_equal 'yd', yard_stick.unit_symbol
  end
  
  test 'measurement to string' do
    length = Measurement.new(5, :meters)
    assert_equal '5 meters', length.to_s
    assert_equal '5 meters', length.to_s(:name)
    assert_equal '5 Meters', length.to_s(:capitalized)
    assert_equal '5 m', length.to_s(:symbol)
    assert_equal '5m', length.to_s(:short)
  end
  
  test 'converting between incompatible units results in nil' do
    apples = Measurement.new(5, :apples)
    assert_nil apples.to(:oranges)
  end
  
  test 'convert_to! raises an exception if conversion fails' do
    apples = Measurement.new(5, :apple)
    assert_raise ArgumentError do
      apples.convert_to! :orange
    end
  end
  
  test 'convert yards to foot unit' do
    length = Measurement.new(5, 'yards')
    assert_equal 15, length.in(:foot).value
  end
  
  test 'convert yards to feet' do
    length = Measurement.new(2, 'yards')
    assert_equal 6, length.in(:feet).value
  end
  
  test 'convert meters to yards' do
    length = Measurement.new(3, :meters)
    assert_nil Measurement.conversion_rates[:meter][:yard]
    assert_equal 3.28084, length.convert_to('yards').value
  end
  
  test 'convert fathom to feet' do
    length = Measurement.new(2.4, :ftm)
    assert_not_equal 4.8, length.in('yds').value
    Measurement.precision = 5
    assert_equal 4.8, length.in('yds').value
  end
  
    
  
  
  teardown do
    remove_all_units
  end
  
end