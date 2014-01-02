require 'test_helper'

class ConversionsTest < Test::Unit::TestCase
  test 'converting units returns nil if not possible' do
    rate = Measurement.conversion_rate_between(:apples, :oranges)
    assert_nil rate
  end
  
  test 'Measurement::add_conversion_rates does a permutation' do
    Measurement.define do
      unit :whole
      unit :half
      unit :quarter
      
      equivalents whole: 1, half: 2, quarter: 4
    end
    
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