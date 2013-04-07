$:.push File.expand_path("../lib", __FILE__)
require File.join('measurement', 'version')

Gem::Specification.new do |s|
  s.name        = 'measurement'
  s.version     = Measurement::VERSION
  s.date        = '2013-04-06'
  s.summary     = 'Measurement'
  s.description = 'tools for converting between different units of measurements with ease'
  s.authors     = [ 'aj0strow' ]
  s.email       = 'alexander.ostrow@gmail.com'
  
  s.add_dependency 'activesupport'  
  
  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- test`.split("\n")
end