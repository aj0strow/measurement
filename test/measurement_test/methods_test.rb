require 'test_helper'

class MethodsTest < Test::Unit::TestCase
  
  class_methods = [ :parse, :units, :add_unit, :remove_unit, :get_unit, 
    :[], :conversion_rate_between, :add_equivalents, :add_eqs, :unitize,
    :units_table, :symbols_table, :conversion_rates, :precision, :precision= ]
  
  class_methods.each do |sym|
    test "Measurement::#{sym} exists" do
      assert_singleton_method Measurement, sym
    end
  end
  
  instance_methods = [ :amount, :unit, :value, :convert_to, :to, :in, 
    :convert_to!, :to!, :in! ]
  
  instance_methods.each do |sym|
    test "Measurement##{sym} exists" do
      assert_instance_method Measurement, sym
    end
  end
  
end