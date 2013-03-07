class Conversions
  
  class SI
  
    class << self
      
      def add_prefix(params)
        Prefix.add params[:name], params[:symbol], params[:power]
      end
    
    end
  
  end
    
end

