# encoding: utf-8

require 'rubygems'
require 'set'
require 'active_support/inflector'

ActiveSupport::Inflector.inflections do |inflect|
  inflect.irregular 'foot', 'feet'
end



__dir__ = File.dirname(__FILE__)

Dir[ File.join(__dir__, 'measurement', '**', '*.rb') ].each { |file| require file }