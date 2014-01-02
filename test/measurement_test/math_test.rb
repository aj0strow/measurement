require 'test_helper'

class MathTest < Test
  setup do
    Measurement.define do
      unit 'seconds', symbol: 's'
      unit 'minute', symbol: 'm'
      eqs minute: 1, seconds: 60
    end
  end
  
  test '+ same unit' do
    t = Measurement.new(5, 'seconds')
    assert_equal 10, (t + t).value
  end
  
  test '+ diff unit' do
    t = Measurement.new(5, :seconds)
    minute = Measurement.new(1, :minute)
    assert_equal 65, (t + minute).value
  end
  
  
  teardown do
    remove_all_units
  end
end