require "#{File.dirname(__FILE__)}/test_helper"

class TestRuboxAuthenticationApi < Test::Unit::TestCase
  def setup
    @rubox = Rubox::Client.new('rrc1d3ntb53tt6b2vhail6rdtrsxov3v')
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

  def test_can_logout
    response = <<-RESP
<?xml version='1.0' encoding='UTF-8' ?>
<response>
<status>logout_ok</status>
</response>
RESP

    @rubox.stubs(:http_get).returns(response)
    assert @rubox.logout
  end

  def test_can_register_new_user
    response = <<-RESP
<?xml version='1.0' encoding='UTF-8' ?>
<response>
<status>successful_register</status>
<auth_token>29135479a888671e0dd6512df4f7a009</auth_token>
<user>
<login>email@example.com</login>
<email>email@example.com</email>
<access_id>398387</access_id>
<user_id>398387</user_id>
<space_amount>1073741824</space_amount>
<space_used>0</space_used>
<max_upload_size>26214400</max_upload_size>
</user>
</response>
RESP

    @rubox.stubs(:http_get).returns(response)
    assert @rubox.register_new_user
  end

  def test_can_verify_registration_email
    response = <<-RESP
<?xml version='1.0' encoding='UTF-8' ?>
<response>
<status>email_ok</status>
</response>
RESP

    @rubox.stubs(:http_get).returns(response)
    assert @rubox.verify_registration_email
  end

  def test_can_get_account_info
    response = <<-RESP
<?xml version='1.0' encoding='UTF-8' ?>
<response>
<status>get_account_info_ok</status>
<user>
<login>email@example.com</login>
<email>email@example.com</email>
<access_id>398387</access_id>
<user_id>398387</user_id>
<space_amount>1073741824</space_amount>
<space_used>0</space_used>
<max_upload_size>2147483648</max_upload_size>
</user>
</response>
RESP

    @rubox.stubs(:http_get).returns(response)
    expected = Rubox::User.new do |u|
      u.login = 'email@example.com'
      u.email = 'email@example.com'
      u.access_id = 398387
      u.user_id = 398387
      u.space_amount = 1073741824
      u.space_used = 0
      u.max_upload_size = 2147483648
    end

    assert_user_equal expected, @rubox.get_account_info
  end
end
