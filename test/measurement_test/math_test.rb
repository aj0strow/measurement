require 'test_helper'

class MathTest < Test
  setup do
    Measurement.define do
      unit 'seconds', symbol: 's'
      unit 'minute', symbol: 'm'
      eqs minute: 1, seconds: 60
    end
    
    @time = Measurement.new(5, 'seconds')
  end
  
  
  test '+' do
    t = @time + @time
    assert_equal 10, t.value
  end
  
  test '-' do
    t = @time - @time
    assert_equal 0, t.value
  end
  
  test '*' do
    t = @time * @time
    assert_equal 25, t.value
  end
  
  test '/' do
    t = @time / @time
    assert_equal 1, t.value
  end
  
  test 'operations convert to correct unit' do
    t = @time + Measurement.new(1, :minute)
    assert_equal 65, t.value
  end
  
  
  teardown do
    remove_all_units
  end
end