require 'test_helper'

class ConstantsTest < Test::Unit::TestCase
  test 'Measurement defined' do
    assert_equal 'constant', defined?(Measurement)
  end
  
  test 'Unit exists' do
    assert_equal 'constant', defined?(Measurement::Unit)
  end  
end