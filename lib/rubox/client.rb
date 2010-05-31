require "net/http"

module Rubox
  class Client
    def initialize(api_key)
      @api_key = api_key
      @base_url = "https://www.box.net/api/1.0/rest?"
    end

    def method_missing(name, *args)
      params = parse_args(args)

      response = 
        http_get("#{@base_url}action=#{name}&api_key=#{@api_key}#{params}")

      Parser.new(response).send(name)
    end

    private

    def http_get(url)
      Net::HTTP.get_response(URI.parse(url)).body.to_s
    end

    def parse_args(args)
      if args && args.count != 0
        raise ArgumentError unless args[0].is_a?(Hash)
        return "&#{args[0].extend(HashExtensions).to_querystring}"
      else
        return ''
      end
    end
  end
end
