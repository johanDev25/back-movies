class WrapperApi
  include HTTParty
  format :json

  base_uri 'https://api.themoviedb.org/3'

  attr_accessor :id

 def initialize(id)
   self.id = id
 end

  def self.get_byId(id)
    response = get("/movie/#{id}?api_key=#{ENV["wrapperapi_key"]}&language=en-US")
    
    if response.success?
      response
    else
      raise response.response
    end
  end

end
