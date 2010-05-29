require "#{File.dirname(__FILE__)}/test_helper"

class TestRuboxAuthenticationApi < Test::Unit::TestCase
  def setup
    @rubox = Rubox.new('rrc1d3ntb53tt6b2vhail6rdtrsxov3v')
  end

  def test_can_get_ticket
  response = <<-RESP
<?xml version='1.0' encoding='UTF-8'?>
<response>
<status>get_ticket_ok</status>
<ticket>bxquuv025arztljze2n438md9zef95e8</ticket>
</response>
RESP

    @rubox.stubs(:http_get).returns(response)
    assert_equal "bxquuv025arztljze2n438md9zef95e8", @rubox.get_ticket
  end

  def test_can_get_auth_token
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

    @rubox.stubs(:http_get).returns(response)
    assert_equal "9byo5bg8d2o3otp0voji0ej0v49bqcmo", @rubox.get_auth_token
  end
end
