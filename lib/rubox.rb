require "net/http"
require "xmlsimple"

class Rubox
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
    parse_response(
      name, http_get("#{@base_url}action=#{name}&api_key=#{@api_key}#{params}"))
  end

  private

  def http_get(url)
    Net::HTTP.get_response(URI.parse(url)).body.to_s
  end

  def get_querystring(args)
    args.map { |k, v| "#{k}=#{v}" }.join('&')
  end

  def parse_response(name, response)
    xml_response = XmlSimple.xml_in(response)
    case name
    when :get_ticket
      xml_response['ticket'].to_s
    when :get_auth_token
      xml_response['auth_token'].to_s
    end
  end
end
