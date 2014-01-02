require 'test_helper'

class DSLTest < Test
  test '#unit singularizes' do
    [ 'dog', 'dogs', :dog, :dogs ].each do |input|
      assert_equal 'dog', Measurement.unit(input).name
    end
  end
  
  test 'units accessible with []' do
    Measurement.unit :inch
    assert_equal Measurement[:inch], Measurement.unit(:inch)
  end
  
  teardown do
    remove_all_units
  end
end