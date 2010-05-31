require "#{File.dirname(__FILE__)}/test_helper"

class TestRuboxClient < Test::Unit::TestCase
  URL_BASE = "https://www.box.net/api/1.0/rest?"

  def setup
    @rubox = Rubox::Client.new("rrc1d3ntb53tt6b2vhail6rdtrsxov3v")
    @rubox.stubs(:parse_response).returns('')
  end

  def test_can_initialize
    assert_not_nil @rubox
  end

  def test_can_create_ticket_request
    response = <<-RESP
<?xml version='1.0' encoding='UTF-8'?>
<response>
<status>get_ticket_ok</status>
<ticket>bxquuv025arztljze2n438md9zef95e8</ticket>
</response>
RESP

    url = URL_BASE + 
      "action=get_ticket&api_key=rrc1d3ntb53tt6b2vhail6rdtrsxov3v"

    @rubox.expects(:http_get).with(url).returns(response)
    @rubox.get_ticket
  end

  def test_can_create_auth_token_request
    response = <<-RESP
<?xml version='1.0' encoding='UTF-8'?>
<response>
<status>get_auth_token_ok</status>
<auth_token>9byo5bg8d2o3otp0voji0ej0v49bqcmo</auth_token>
<user>
<login>stas@itscript.com</login>
<email>stas@itscript.com</email>
<access_id>453</access_id>
<user_id>453</user_id>
<space_amount>2147483648</space_amount>
<space_used>1024</space_used>
<max_upload_size>26214400</max_upload_size>
</user>
</response>
RESP

    url = URL_BASE +
      "action=get_auth_token&api_key=rrc1d3ntb53tt6b2vhail6rdtrsxov3v&" +
      "ticket=udd863k39gn9mioc6ym2c6erbqm8q"

    @rubox.expects(:http_get).with(url).returns(response)
    @rubox.get_auth_token(:ticket => "udd863k39gn9mioc6ym2c6erbqm8q")
  end
end
