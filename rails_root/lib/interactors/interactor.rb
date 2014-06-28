class Interactor
  attr_reader :request, :response

  def initialize(request = {})
    @request = request
    @response = Response.new
    @response.interactor = self.class.to_s
  end

  def call
    @response
  end
end
