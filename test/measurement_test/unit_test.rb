require 'test_helper'

class UnitTest < Test::Unit::TestCase
  setup do
    Unit ||= Measurement::Unit
  end
  
  
  test 'create new unit' do
    fathom = Unit.new(:fathom)
    
    assert_equal :fathom, fathom.name
    assert_equal 'fathom', fathom.to_s
    assert_equal "#<Unit :fathom>", fathom.inspect
  end
  
  test 'create new unit with symbol' do
    inch = Unit.new(:inch, symbol: 'in')

    assert_equal 'in', inch.symbol
    assert_equal "#<Unit :inch 'in'>", inch.inspect
  end
  
  test 'create new si unit' do
    meter = Unit.new(:meter, symbol: 'm', si: true)
    
    assert meter.si?
    assert meter.si_unit?
    assert_equal "#<Unit :meter 'm' si=true>", meter.inspect
  end
  
  test 'create unit with string' do
    barrel = Unit.new('barrel')
    assert_equal :barrel, barrel.name
  end
  
  test 'si should return boolean' do
    ounce = Unit.new(:ounce)
    liter = Unit.new(:liter, si: false)
    
    assert_not_nil ounce.si?
    assert_equal ounce.si?, liter.si?
    assert_equal false, liter.si?
  end
  
  test 'create unit with plural name' do
    assert_equal :angstrom, Unit.new('angstroms').name
    assert_equal :joule, Unit.new(:joules).name
  end
  
  test 'symbol should default to name' do
    assert_equal 'sheep', Unit.new(:sheep).symbol
  end
  
  test 'create unit with symbolic symbol' do
    assert_equal 'cm', Unit.new(:centimeter, symbol: :cm).symbol
  end
end