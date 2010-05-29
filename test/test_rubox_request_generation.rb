require "#{File.dirname(__FILE__)}/test_helper"

class TestRuboxRequestGeneration < Test::Unit::TestCase
  URL_BASE = "https://www.box.net/api/1.0/rest?"

  def setup
    @rubox = Rubox::Client.new("rrc1d3ntb53tt6b2vhail6rdtrsxov3v")
    @rubox.stubs(:parse_response).returns('')
  end

  def test_can_initialize
    assert_not_nil @rubox
  end

  def test_can_create_querystring
    args = {
      :action => 'get_auth_token',
      :api_key => 'rrc1d3ntb53tt6b2vhail6rdtrsxov3v',
      :ticket => 'udd863k39gn9mioc6ym2c6erbqm8q'
    }

    result = @rubox.instance_eval { get_querystring(args) }
    assert(result =~ /action=get_auth_token/, 'action')
    assert(result =~ /api_key=rrc1d3ntb53tt6b2vhail6rdtrsxov3v/, 'api_key')
    assert(result =~ /ticket=udd863k39gn9mioc6ym2c6erbqm8q/, 'ticket')
  end

  def test_can_create_ticket_request
    url = URL_BASE + 
      "action=get_ticket&api_key=rrc1d3ntb53tt6b2vhail6rdtrsxov3v"

    @rubox.expects(:http_get).with(url)
    @rubox.get_ticket
  end

  def test_can_create_auth_token_request
    url = URL_BASE +
      "action=get_auth_token&api_key=rrc1d3ntb53tt6b2vhail6rdtrsxov3v&" +
      "ticket=udd863k39gn9mioc6ym2c6erbqm8q"

    @rubox.expects(:http_get).with(url)
    @rubox.get_auth_token(:ticket => "udd863k39gn9mioc6ym2c6erbqm8q")
  end
end
