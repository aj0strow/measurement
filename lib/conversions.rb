# encoding: utf-8

dirname = File.dirname(__FILE__)

Dir[ File.join(dirname, 'conversions', '*') ].each { |file| require file }

File.open(File.join(dirname, 'data', 'si_prefixes.txt')) do |f|
  f.read.split.each_slice(3) do |name, symbol, power|
    Conversions::SI.add_prefix name: name, symbol: symbol, power: power.to_i
  end
end