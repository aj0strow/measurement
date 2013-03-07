# encoding: utf-8

require 'test_helper'

class SiUnitsTest < Test::Unit::TestCase
  
  test 'all methods created' do
    [ :name_to_symbol, :name_to_power, 
      :symbol_to_name, :symbol_to_power,
      :power_to_name, :power_to_symbol 
    ].each do |method|
      assert SI::Prefix.respond_to?(method)
    end
  end
  
  test 'can add si units' do
    prefix = SI.add_prefix(name: 'kilo', symbol: 'k', power: 3)
    assert_equal 'kilo', prefix.name
    assert_equal 'k', prefix.symbol
    assert_equal 3, prefix.power
    assert_equal 1000, prefix.multiplier
  end
  
  test 'k - kilo - 1000' do
    assert_equal 'k', SI::Prefix.name_to_symbol('kilo')
    assert_equal 3, SI::Prefix.name_to_power('kilo')
    
    assert_equal 'kilo', SI::Prefix.symbol_to_name('k')
    assert_equal 3, SI::Prefix.symbol_to_power('k')
    
    assert_equal 'kilo', SI::Prefix.power_to_name(3)
    assert_equal 'k', SI::Prefix.power_to_symbol(3)
  end
  
  test 'all names' do
    all_names = %w( yotta zetta exa peta tera giga mega kilo hecto deca
       deci centi milli micro nano pico femto atto zepto yocto )
       
    assert_equal all_names, SI::Prefix.names.keys
  end
  
  test 'all symbols' do
    all_symbols = %w( Y Z E P T G M k h da d c m µ n p f a z y )
    assert_equal all_symbols, SI::Prefix.symbols.keys
  end
  
  test 'all powers' do
    all_powers = (-24..24).step(3).to_a + (-2..2).step(1).to_a - [0]
    assert_equal all_powers.sort.reverse, SI::Prefix.powers.keys
  end
  
end