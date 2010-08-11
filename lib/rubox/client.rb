require "net/http"

module Rubox
  # == Description
  # Client interface to Box.net API. Uses the REST API protocol.
  class Client
    # Creates a new +Client+.
    #
    # api_key:: Your API Key that was assigned by Box.net.
    def initialize(api_key)
      @api_key = api_key
      @base_url = "https://www.box.net/api/1.0/rest?"
    end

    # Messages sent to +Client+ are dynamcially translated into API 
    # compatible REST based calls.
    #
    # name:: The name of the API action.
    # args:: Any parameters needed by the action as a +Hash+; or blank.
    #
    # === Examples
    # c = Client.new('your_api_key')
    #
    # c.get_ticket => 'api_ticket'
    #
    # c.set_description(:target => 'file', 
    # :target_id => '123', :description => 'My description.') => true
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
