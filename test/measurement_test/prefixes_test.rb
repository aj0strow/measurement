# encoding: utf-8

require 'test_helper'

class PrefixesTest < Test::Unit::TestCase
  setup do
    Measurement.unit :second, symbol: 's', prefix: true
  end
  
  
  test 'yotta' do
    t = Measurement.new(3, 'Ys')
    assert_equal 'yottasecond', t.unit.name
    assert_equal 3e24, t.in('seconds').value
  end
  
  test 'zetta' do
    t = Measurement.new(3, 'Zs')
    assert_equal 'zettasecond', t.unit.name
    assert_equal 3e21, t.in('seconds').value
  end
  
  test 'exa' do
    t = Measurement.new(3, 'Es')
    assert_equal 'exasecond', t.unit.name
    assert_equal 3e18, t.in('seconds').value
  end
  
  test 'peta' do
    t = Measurement.new(3, 'Ps')
    assert_equal 'petasecond', t.unit.name
    assert_equal 3e15, t.in('seconds').value
  end
  
  test 'tera' do
    t = Measurement.new(3, 'Ts')
    assert_equal 'terasecond', t.unit.name
    assert_equal 3e12, t.in('seconds').value
  end
  
  test 'giga' do
    t = Measurement.new(3, 'Gs')
    assert_equal 'gigasecond', t.unit.name
    assert_equal 3e9, t.in('seconds').value
  end
  
  test 'mega' do
    t = Measurement.new(3, 'Ms')
    assert_equal 'megasecond', t.unit.name
    assert_equal 3e6, t.in('seconds').value
  end
  
  test 'kilo' do
    t = Measurement.new(3, 'ks')
    assert_equal 'kilosecond', t.unit.name
    assert_equal 3e3, t.in('seconds').value
  end
  
  test 'hecto' do
    t = Measurement.new(3, 'hs')
    assert_equal 'hectosecond', t.unit.name
    assert_equal 3e2, t.in('seconds').value
  end
  
  test 'deca' do
    t =  Measurement.new(3, 'das')
    assert_equal 'decasecond', t.unit.name
    assert_equal 3e1, t.in('seconds').value
  end
  
  test 'deci' do
    t = Measurement.new(3, 'ds')
    assert_equal 'decisecond', t.unit.name
    assert_in_delta 3e-1, t.in('seconds').value, 1e-14
  end
  
  test 'centi' do
    t = Measurement.new(3, 'cs')
    assert_equal 'centisecond', t.unit.name
    assert_in_delta 3e-2, t.in('seconds').value, 1e-14
  end
  
  test 'milli' do
    t = Measurement.new(3, 'ms')
    assert_equal 'millisecond', t.unit.name
    assert_in_delta 3e-3, t.in('seconds').value, 1e-14
  end
  
  test 'micro' do
    t = Measurement.new(3, 'µs')
    assert_equal 'microsecond', t.unit.name
    assert_in_delta 3e-6, t.in('seconds').value, 1e-14
  end
  
  test 'nano' do
    t = Measurement.new(3, 'ns')
    assert_equal 'nanosecond', t.unit.name
    assert_in_delta 3e-9, t.in('seconds').value, 1e-14
  end
  
  test 'pico' do
    t = Measurement.new(3, 'ps')
    assert_equal 'picosecond', t.unit.name
    assert_in_delta 3e-12, t.in('seconds').value, 1e-14
  end
  
  test 'femto' do
    t = Measurement.new(3, 'fs')
    assert_equal 'femtosecond', t.unit.name
    assert_in_delta 3e-15, t.in('seconds').value, 1e-14
  end
  
  test 'atto' do
    t = Measurement.new(3, 'as')
    assert_equal 'attosecond', t.unit.name
    assert_in_delta 3e-18, t.in('seconds').value, 1e-14
  end
  
  test 'zepto' do
    t = Measurement.new(3, 'zs')
    assert_equal 'zeptosecond', t.unit.name
    assert_in_delta 3e-21, t.in('seconds').value, 1e-14
  end
  
  test 'yocto' do
    t = Measurement.new(3, 'ys')
    assert_equal 'yoctosecond', t.unit.name
    assert_in_delta 3e-24, t.in('seconds').value, 1e-14
  end
  
  test 'only a few' do
    Measurement.unit :byte, symbol: 'B', prefix: 3..24
    size = Measurement.new(5000, 'bytes')
    assert_equal 5, size.in('kB').value
    assert_nil size.in('nB')
  end
  
  
  teardown do
    remove_all_units
  end
end