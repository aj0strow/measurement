require 'test_helper'

class ComparableTest < Test
  
  setup do
    Measurement.define do
      unit 'meter', symbol: 'm', prefix: true
    end
    @meter = Measurement.new(1, :meter)
  end
  
  test 'meter equal to meter' do
    assert @meter == @meter
  end
  
  test 'meter greater than centimeter' do
    assert @meter > Measurement.new(1, :centimeter)
  end
  
  test 'meter smaller than 101 centimeters' do
    assert @meter < Measurement.new(101, :centimeters)
  end
  
  test 'sorting' do
    measurements = [ @meter, Measurement.new(5, :centimeters) ].sort
    assert_equal @meter, measurements.last
  end
  
end