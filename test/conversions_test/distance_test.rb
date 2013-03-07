require 'test_helper'

class DistanceTest < Test::Unit::TestCase
  
  test 'precision defaults to 5 but can be set' do
    assert_equal 5, Distance.precision
    Distance.precision = 3
    assert_equal 3, Distance.precision
    Distance.precision = 5
  end
 
end