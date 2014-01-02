$:.push File.expand_path('../lib', __FILE__)
require 'measurement/version'

Gem::Specification.new do |s|
  s.name        = 'measurement'
  s.version     = Measurement::VERSION
  s.date        = '2013-04-06'
  s.summary     = 'Measurement'
  s.description = 'tools for converting between different units of measurements with ease'
  s.authors     = %w(aj0strow)
  s.email       = 'alexander.ostrow@gmail.com'
  
  s.require_path = 'lib'
  
  s.add_dependency 'activesupport'
  
  s.add_development_dependency 'rake'
  s.add_development_dependency 'bundler'
  s.add_development_dependency 'minitest', '4.2'
  
  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- test`.split("\n")
  
  s.license = 'MIT'
end