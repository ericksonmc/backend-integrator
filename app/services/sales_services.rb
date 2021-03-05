class SalesServices
  include ApplicationHelper
  require 'httparty'

  def initialize
    @options = {
      headers: {
        "Content-Type" => 'application/json',
        "tokenSPJ" => "6a236abc8aaa8f2ee6964204af0d323748e6320998203146ee97cc1eda30ba3c"
      }
    }
  end

  def send_plays(params)
    data = {
      query: {
        data: params
      }
    }
    response = HTTParty.post('https://www.centrodeapuestas.com/centinela/api/v1/ventas/nueva_venta_v2',
      body: params.to_json,
      headers: {
        "Content-Type" => 'application/json',
        "tokenSPJ" => "6a236abc8aaa8f2ee6964204af0d323748e6320998203146ee97cc1eda30ba3c"
      }
    )

    return get_response(response)
  end

  def get_response(request)
    {
      data: JSON.parse(request.body),
      headers: request.headers,
      status: request.code
    }
  end

end