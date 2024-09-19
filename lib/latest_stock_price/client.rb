# lib/latest_stock_price/client.rb

require 'net/http'
require 'uri'
require 'json'

module LatestStockPrice
  class Client
    BASE_URL = 'https://latest-stock-price.p.rapidapi.com/any'
    API_HOST = 'latest-stock-price.p.rapidapi.com'
    API_KEY = '1504aecc67msh8100e5e1e79da53p152e91jsn90180190504d' # Replace with YOUR actual key

    def initialize(api_key = API_KEY)
      @api_key = api_key
    end

    def price(stock_code)
      uri = URI("#{BASE_URL}?Identifier=#{stock_code}")
      make_request(uri)
    end

    def prices(stock_codes)
      identifiers = stock_codes.join('%2C')
      uri = URI("#{BASE_URL}?Identifier=#{identifiers}")
      make_request(uri)
    end

    def price_all
      uri = URI(BASE_URL)
      make_request(uri)
    end

    private

    def make_request(uri)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(uri)
      request['x-rapidapi-host'] = API_HOST
      request['x-rapidapi-key'] = @api_key

      response = http.request(request)
      
      if response.is_a?(Net::HTTPSuccess)
        JSON.parse(response.body)
      else
        { error: "Failed to fetch data", status: response.code }
      end
    end
  end
end