# encoding: utf-8

require 'test_helper'

class ParseTest < Test::Unit::TestCase
  setup do
    Measurement.unit(:meter, symbol: 'm', si: true)
    Measurement.unit(:mole, symbol: 'mol', si: true)
  end
  
  
  test 'parse no number' do
    assert_nil Measurement.parse('')
    assert_nil Measurement.parse(' cm')
    assert_nil Measurement.parse('x inches')
  end
  
  test 'parse no units' do
    assert_nil Measurement.parse('123')
    assert_nil Measurement.parse('123.13')
    assert_nil Measurement.parse('-31233e-3 ?')
  end
  
  test 'parse integer and unit name' do
    length = Measurement.parse('1 meter')
    assert_equal 1, length.value
    assert_equal 'meter', length.unit.name
  end
  
  test 'parse integer and plural name' do
    length = Measurement.parse('17 meters')
    assert_equal 17, length.value
    assert_equal 'meter', length.unit.name
  end
  
  test 'parse negative integer' do
    length = Measurement.parse('-34 meters')
    assert_equal -34, length.value
  end
  
  test 'parse float' do
    length = Measurement.parse('1.42 meters')
    assert_equal 1.42, length.value
  end
  
  test 'parse negative float' do
    length = Measurement.parse('-.5 meter')
    assert_equal -0.5, length.value
  end
  
  test 'parse int and symbol with space' do
    length = Measurement.parse('52 m')
    assert_equal 52, length.value
    assert_equal 'meter', length.unit.name
  end
  
  test 'parse negative float and symbol with space' do
    length = Measurement.parse('-5.33 m')
    assert_equal -5.33, length.value
  end
  
  test 'parse negative int and symbol no space' do
    length = Measurement.parse('-2m')
    assert_equal -2, length.value
    assert_equal 'meter', length.unit.name
  end
    
  test 'parse float and symbol no space' do
    length = Measurement.parse('.23m')
    assert_equal 0.23, length.value
    assert_equal 'meter', length.unit.name
  end
  
  test 'parse negative exponent and symbol no space' do
    substance = Measurement.parse('1e-3mol')
    assert_equal 0.001, substance.value
    assert_equal 'mole', substance.unit.name
  end
  
  test 'parse random unit' do
    length = Measurement.parse('$15.23 dollars')
    assert_equal 15.23, length.value
    assert_equal 'dollar', length.unit.name
  end
  
  test 'parse angstroms' do
    Measurement.unit(:angstrom, symbol: 'å')
    length = Measurement.parse('5å')
    assert_equal 5, length.value
    assert_equal 'angstrom', length.unit.name
  end
  
  
  teardown do
    remove_all_units
  end  
end