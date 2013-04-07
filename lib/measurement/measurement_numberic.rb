# encoding: utf-8

class Measurement
  
  [ :+@, :-@, :ceil, :conj, :conjugate, :floor, :abs, :magnitude, :round, 
    :truncate, :real, :modulo, :divmod, :div  ].each do |sym|
    
      define_method(sym) do |*args|
        Measurement.new( amount.send(sym, *args), unit )
      end
    
  end

  [ :zero?, :to_i, :to_int, :to_f, :to_r, :to_c, :real?, :nonzero?, 
    :integer? ].each do |sym|
      
    define_method(sym) do |*args|
      amount.send(sym, *args)
    end  
      
  end
  
end