require 'active_support/inflector'

ActiveSupport::Inflector.inflections do |inflect|
  inflect.irregular 'foot', 'feet'
end