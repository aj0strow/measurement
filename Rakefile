require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.pattern = 'test/measurement_test/*.rb'
  t.verbose = false
end

task default: :test