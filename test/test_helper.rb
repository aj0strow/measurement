require 'test/unit'
require 'conversions'

SI = Conversions::SI

def test(test_name, &block)
  define_method("test_#{ test_name.gsub(/\s+/, '_') }", &block)
end