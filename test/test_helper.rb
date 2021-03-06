require 'minitest/autorun'
require 'minitest/colorize'
require 'measurement'

class Test < Minitest::Unit::TestCase
  module Callbacks
    def startup(&block)
      define_singleton_method('startup', &block)
    end

    def setup(&block)
      define_method('setup', &block)
    end

    def test(test_name, &block)
      define_method("test #{ test_name }", &block)
    end

    def cleanup(&block)
      define_method('cleanup', &block)
    end

    def teardown(&block)
      define_method('teardown', &block)
    end

    def shutdown(&block)
      define_singleton_method('shutdown', &block)
    end
  end
  
  module Assertions
    def assert_singleton_method(object, sym)
      assert object.respond_to?(sym), "Expected #{object} singleton to respond to #{sym}"
    end

    def assert_instance_method(object, sym)
       assert object.method_defined?(sym), "Expected #{object} instance to respond to #{sym}"
    end
  end
  
  module Helpers
    def remove_all_units
      Measurement.units.each do |unit|
        Measurement.remove(unit)
      end
      Measurement.precision = nil
    end
  end
  
  extend Callbacks
  include Assertions
  include Helpers
end





