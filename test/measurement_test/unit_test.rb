require 'test_helper'

class UnitTest < Test
  setup do
    Unit ||= Measurement::Unit
  end
  
  
  test 'create new unit' do
    fathom = Unit.new 'fathom'
    assert_equal 'fathom', fathom.name
    assert_equal 'fathom', fathom.symbol
    assert_equal false, fathom.si?
  end
  
  test 'create unit with symbol' do
    inch = Unit.new 'inch', symbol: 'in'
    assert_equal 'in', inch.symbol
  end
  
  test 'create new si unit' do
    meter = Unit.new 'meter', symbol: 'm', si: true
    assert meter.si?
  end
  
  test '#inspect with symbol' do
    unit = Unit.new 'unit', symbol: 'u'
    assert_equal unit.inspect, '#<Unit unit (u)>'
  end
  
  test '#inspect without symbol' do
    unit = Unit.new 'unit'
    assert_equal unit.inspect, '#<Unit unit>'
  end
end