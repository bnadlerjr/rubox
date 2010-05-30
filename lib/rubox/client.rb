require "net/http"

module Rubox
  class Client
    def initialize(api_key)
      @api_key = api_key
      @base_url = "https://www.box.net/api/1.0/rest?"
    end

    def method_missing(name, *args)
      if args && args.count != 0
        params = "&#{get_querystring(args[0])}"
      else
        params = ''
      end

      response = 
        http_get("#{@base_url}action=#{name}&api_key=#{@api_key}#{params}")

      Parser.new(response).send(name)
    end

    private

    def http_get(url)
      Net::HTTP.get_response(URI.parse(url)).body.to_s
    end

    def get_querystring(args)
      args.map { |k, v| "#{k}=#{v}" }.join('&')
    end
  end
end
