require File.expand_path "#{File.dirname(__FILE__)}/test_helper"

class TestRuboxClient < Test::Unit::TestCase
  URL_BASE = "https://www.box.net/api/1.0/rest?"

  def setup
    @rubox = Rubox::Client.new("rrc1d3ntb53tt6b2vhail6rdtrsxov3v")
    @response = <<-RESP
<?xml version='1.0' encoding='UTF-8'?>
<response>
<status>ok</status>
</response>
RESP
  end

  def test_can_initialize
    assert_not_nil @rubox
  end

  def test_invalid_method_raises_error
    assert_raises NoMethodError do
      @rubox.foo
    end
  end

  def test_can_create_ticket_request
    url = URL_BASE + 
      "action=get_ticket" +
      "&api_key=rrc1d3ntb53tt6b2vhail6rdtrsxov3v"

    @rubox.expects(:http_get).with(url).returns(@response)
    @rubox.get_ticket
  end

  def test_can_create_auth_token_request
    url = URL_BASE +
      "action=get_auth_token" + 
      "&api_key=rrc1d3ntb53tt6b2vhail6rdtrsxov3v" +
      "&ticket=udd863k39gn9mioc6ym2c6erbqm8q"

    @rubox.expects(:http_get).with(url).returns(@response)
    @rubox.get_auth_token(:ticket => "udd863k39gn9mioc6ym2c6erbqm8q")
  end

  def test_can_create_logout_request
    url = URL_BASE + 
      "action=logout" + 
      "&api_key=rrc1d3ntb53tt6b2vhail6rdtrsxov3v" +
      "&auth_token=d2dqkrr6bae6ckua17osf9o1fhox9ypf"

    @rubox.expects(:http_get).with(url).returns(@response)
    @rubox.logout(:auth_token => 'd2dqkrr6bae6ckua17osf9o1fhox9ypf')
  end

  def test_can_create_register_new_user_request
    url = URL_BASE + 
      "action=register_new_user" + 
      "&api_key=rrc1d3ntb53tt6b2vhail6rdtrsxov3v" +
      "&login=email@example.com&password=123"

    @rubox.expects(:http_get).with(url).returns(@response)
    @rubox.register_new_user(:login => 'email@example.com', :password => '123')
  end

  def test_can_create_verify_registration_email_request
    url = URL_BASE + 
      "action=verify_registration_email" +
      "&api_key=rrc1d3ntb53tt6b2vhail6rdtrsxov3v" +
      "&login=email@example.com"

    @rubox.expects(:http_get).with(url).returns(@response)
    @rubox.verify_registration_email(:login => 'email@example.com')
  end

  def test_can_create_get_account_info_request
    url = URL_BASE + 
      "action=get_account_info" + 
      "&api_key=rrc1d3ntb53tt6b2vhail6rdtrsxov3v" +
      "&auth_token=d2dqkrr6bae6ckua17osf9o1fhox9ypf"

    Rubox::Parser.any_instance.stubs(:get_account_info)
    @rubox.expects(:http_get).with(url).returns(@response)
    @rubox.get_account_info(:auth_token => 'd2dqkrr6bae6ckua17osf9o1fhox9ypf')
  end

  def test_can_create_get_account_tree_request
    url = URL_BASE +
      "action=get_account_tree" + 
      "&api_key=rrc1d3ntb53tt6b2vhail6rdtrsxov3v" +
      "&auth_token=d2dqkrr6bae6ckua17osf9o1fhox9ypf" + 
      "&folder_id=0" + 
      "&params[]=nozip" +
      "&params[]=nofiles"

    Rubox::Parser.any_instance.stubs(:get_account_tree)
    @rubox.expects(:http_get).with(url).returns(@response)
    @rubox.get_account_tree(:auth_token => 'd2dqkrr6bae6ckua17osf9o1fhox9ypf',
      :folder_id => 0, :params => ['nozip', 'nofiles'])
  end

  def test_can_create_a_create_folder_request
    url = URL_BASE + 
      "action=create_folder" + 
      "&api_key=rrc1d3ntb53tt6b2vhail6rdtrsxov3v" +
      "&auth_token=d2dqkrr6bae6ckua17osf9o1fhox9ypf" + 
      "&name=New Folder" + 
      "&parent_id=0" +
      "&share=1"

    @rubox.expects(:http_get).with(url).returns(@response)
    @rubox.create_folder(:auth_token => 'd2dqkrr6bae6ckua17osf9o1fhox9ypf', 
      :parent_id => 0, :name => 'New Folder', :share => 1)
  end

  def test_can_create_move_request
    url = URL_BASE + 
      "action=move" + 
      "&api_key=rrc1d3ntb53tt6b2vhail6rdtrsxov3v" +
      "&auth_token=d2dqkrr6bae6ckua17osf9o1fhox9ypf" + 
      "&destination_id=2" +
      "&target=file" + 
      "&target_id=1"

    @rubox.expects(:http_get).with(url).returns(@response)
    @rubox.move(:auth_token => 'd2dqkrr6bae6ckua17osf9o1fhox9ypf',
      :target => 'file',
      :target_id => 1, 
      :destination_id => 2)
  end

  def test_can_create_copy_request
    url = URL_BASE + 
      "action=copy" + 
      "&api_key=rrc1d3ntb53tt6b2vhail6rdtrsxov3v" +
      "&auth_token=d2dqkrr6bae6ckua17osf9o1fhox9ypf" + 
      "&destination_id=2" +
      "&target=file" + 
      "&target_id=1"
   
    @rubox.expects(:http_get).with(url).returns(@response)
    @rubox.copy(:auth_token => 'd2dqkrr6bae6ckua17osf9o1fhox9ypf',
      :target => 'file',
      :target_id => 1, 
      :destination_id => 2)
  end

  def test_can_create_rename_request
    url = URL_BASE + 
      "action=rename" + 
      "&api_key=rrc1d3ntb53tt6b2vhail6rdtrsxov3v" +
      "&auth_token=d2dqkrr6bae6ckua17osf9o1fhox9ypf" + 
      "&new_name=New Name" +
      "&target=file" + 
      "&target_id=1"
   
    @rubox.expects(:http_get).with(url).returns(@response)
    @rubox.rename(:auth_token => 'd2dqkrr6bae6ckua17osf9o1fhox9ypf',
      :target => 'file',
      :target_id => 1, 
      :new_name => 'New Name')
  end

  def test_can_create_delete_request
    url = URL_BASE + 
      "action=delete" + 
      "&api_key=rrc1d3ntb53tt6b2vhail6rdtrsxov3v" +
      "&auth_token=d2dqkrr6bae6ckua17osf9o1fhox9ypf" + 
      "&target=file" + 
      "&target_id=1"
   
    @rubox.expects(:http_get).with(url).returns(@response)
    @rubox.delete(:auth_token => 'd2dqkrr6bae6ckua17osf9o1fhox9ypf',
      :target => 'file',
      :target_id => 1)
  end

  def test_can_create_get_file_info_request
    url = URL_BASE + 
      "action=get_file_info" + 
      "&api_key=rrc1d3ntb53tt6b2vhail6rdtrsxov3v" +
      "&auth_token=d2dqkrr6bae6ckua17osf9o1fhox9ypf" + 
      "&file_id=1"
   
    Rubox::Parser.any_instance.stubs(:get_file_info)
    @rubox.expects(:http_get).with(url).returns(@response)
    @rubox.get_file_info(:auth_token => 'd2dqkrr6bae6ckua17osf9o1fhox9ypf',
      :file_id => 1)
  end

  def test_can_create_set_description_request
    url = URL_BASE + 
      "action=set_description" + 
      "&api_key=rrc1d3ntb53tt6b2vhail6rdtrsxov3v" +
      "&auth_token=d2dqkrr6bae6ckua17osf9o1fhox9ypf" + 
      "&description=My new description" +
      "&target=file" + 
      "&target_id=1"
   
    @rubox.expects(:http_get).with(url).returns(@response)
    @rubox.set_description(:auth_token => 'd2dqkrr6bae6ckua17osf9o1fhox9ypf',
      :target => 'file',
      :target_id => 1, 
      :description => 'My new description')
  end

  def test_can_create_public_share_request
    url = URL_BASE +
      "action=public_share" + 
      "&api_key=rrc1d3ntb53tt6b2vhail6rdtrsxov3v" +
      "&auth_token=d2dqkrr6bae6ckua17osf9o1fhox9ypf" + 
      "&emails[]=john@example.com" + 
      "&emails[]=joe@example.com" + 
      "&message=Email message" + 
      "&password=foo" +
      "&target=file" + 
      "&target_id=1"

    @rubox.expects(:http_get).with(url).returns(@response)
    @rubox.public_share(:auth_token => 'd2dqkrr6bae6ckua17osf9o1fhox9ypf',
      :target => 'file',
      :target_id => 1,
      :password => 'foo',
      :message => 'Email message',
      :emails => ['john@example.com', 'joe@example.com'])
  end

  def test_can_create_public_unshare_request
    url = URL_BASE + 
      "action=public_unshare" + 
      "&api_key=rrc1d3ntb53tt6b2vhail6rdtrsxov3v" +
      "&auth_token=d2dqkrr6bae6ckua17osf9o1fhox9ypf" + 
      "&target=file" + 
      "&target_id=1"
   
    @rubox.expects(:http_get).with(url).returns(@response)
    @rubox.public_unshare(:auth_token => 'd2dqkrr6bae6ckua17osf9o1fhox9ypf',
      :target => 'file',
      :target_id => 1)
  end

  def test_can_create_private_share_request
    url = URL_BASE +
      "action=private_share" + 
      "&api_key=rrc1d3ntb53tt6b2vhail6rdtrsxov3v" +
      "&auth_token=d2dqkrr6bae6ckua17osf9o1fhox9ypf" + 
      "&emails[]=john@example.com" + 
      "&emails[]=joe@example.com" + 
      "&message=Email message" + 
      "&notify=true" +
      "&target=file" + 
      "&target_id=1"

    @rubox.expects(:http_get).with(url).returns(@response)
    @rubox.private_share(:auth_token => 'd2dqkrr6bae6ckua17osf9o1fhox9ypf',
      :target => 'file',
      :target_id => 1,
      :notify => true,
      :message => 'Email message',
      :emails => ['john@example.com', 'joe@example.com'])
  end

  def test_can_create_a_request_friends_request
    url = URL_BASE +
      "action=request_friends" + 
      "&api_key=rrc1d3ntb53tt6b2vhail6rdtrsxov3v" +
      "&auth_token=d2dqkrr6bae6ckua17osf9o1fhox9ypf" + 
      "&emails[]=john@example.com" + 
      "&emails[]=joe@example.com" + 
      "&message=Email message" + 
      "&params[]=no_email" +
      "&params[]=box_auto_subscribe"

    @rubox.expects(:http_get).with(url).returns(@response)
    @rubox.request_friends(:auth_token => 'd2dqkrr6bae6ckua17osf9o1fhox9ypf',
      :params => ['no_email', 'box_auto_subscribe'],
      :message => 'Email message',
      :emails => ['john@example.com', 'joe@example.com'])
  end

  def test_can_create_get_friends_request
    url = URL_BASE +
      "action=get_friends" + 
      "&api_key=rrc1d3ntb53tt6b2vhail6rdtrsxov3v" +
      "&auth_token=d2dqkrr6bae6ckua17osf9o1fhox9ypf" + 
      "&params[]=nozip"

    Rubox::Parser.any_instance.stubs(:get_friends)
    @rubox.expects(:http_get).with(url).returns(@response)
    @rubox.get_friends(:auth_token => 'd2dqkrr6bae6ckua17osf9o1fhox9ypf',
      :params => 'nozip')
  end

  def test_can_create_add_to_mybox_request
    url = URL_BASE +
      "action=add_to_mybox" + 
      "&api_key=rrc1d3ntb53tt6b2vhail6rdtrsxov3v" +
      "&auth_token=d2dqkrr6bae6ckua17osf9o1fhox9ypf" + 
      "&file_id=4940" + 
      "&folder_id=0" + 
      "&public_name=some_file" + 
      "&tags[]=tag1" +
      "&tags[]=tag2"

    @rubox.expects(:http_get).with(url).returns(@response)
    @rubox.add_to_mybox(:auth_token => 'd2dqkrr6bae6ckua17osf9o1fhox9ypf',
      :file_id => 4940,
      :folder_id => 0,
      :public_name => 'some_file',
      :tags => ['tag1', 'tag2'])
  end

  def test_can_create_add_to_tag_request
    url = URL_BASE +
      "action=add_to_tag" + 
      "&api_key=rrc1d3ntb53tt6b2vhail6rdtrsxov3v" +
      "&auth_token=d2dqkrr6bae6ckua17osf9o1fhox9ypf" + 
      "&tags[]=tag1" +
      "&tags[]=tag2" +
      "&target=file" + 
      "&target_id=0" 

    @rubox.expects(:http_get).with(url).returns(@response)
    @rubox.add_to_tag(:auth_token => 'd2dqkrr6bae6ckua17osf9o1fhox9ypf',
      :target => 'file',
      :target_id => 0,
      :tags => ['tag1', 'tag2'])
  end

  def test_can_create_export_tags_request
    url = URL_BASE +
      "action=export_tags" + 
      "&api_key=rrc1d3ntb53tt6b2vhail6rdtrsxov3v" +
      "&auth_token=d2dqkrr6bae6ckua17osf9o1fhox9ypf"

    Rubox::Parser.any_instance.stubs(:export_tags)
    @rubox.expects(:http_get).with(url).returns(@response)
    @rubox.export_tags(:auth_token => 'd2dqkrr6bae6ckua17osf9o1fhox9ypf')
  end

  def test_can_create_get_comments_request
    url = URL_BASE +
      "action=get_comments" + 
      "&api_key=rrc1d3ntb53tt6b2vhail6rdtrsxov3v" +
      "&auth_token=d2dqkrr6bae6ckua17osf9o1fhox9ypf" + 
      "&target=file" + 
      "&target_id=3522216"

    Rubox::Parser.any_instance.stubs(:get_comments)
    @rubox.expects(:http_get).with(url).returns(@response)
    @rubox.get_comments(:auth_token => 'd2dqkrr6bae6ckua17osf9o1fhox9ypf',
      :target => 'file',
      :target_id => 3522216)
  end

  def test_can_create_add_comment_request
     url = URL_BASE +
      "action=add_comment" + 
      "&api_key=rrc1d3ntb53tt6b2vhail6rdtrsxov3v" +
      "&auth_token=d2dqkrr6bae6ckua17osf9o1fhox9ypf" + 
      "&message=Some message." +
      "&target=file" + 
      "&target_id=3522216"

    @rubox.expects(:http_get).with(url).returns(@response)
    @rubox.add_comment(:auth_token => 'd2dqkrr6bae6ckua17osf9o1fhox9ypf',
      :message => 'Some message.',
      :target => 'file',
      :target_id => 3522216)
  end

  def test_can_create_delete_comment_request
     url = URL_BASE +
      "action=delete_comment" + 
      "&api_key=rrc1d3ntb53tt6b2vhail6rdtrsxov3v" +
      "&auth_token=d2dqkrr6bae6ckua17osf9o1fhox9ypf" + 
      "&target_id=3522216"

    @rubox.expects(:http_get).with(url).returns(@response)
    @rubox.delete_comment(:auth_token => 'd2dqkrr6bae6ckua17osf9o1fhox9ypf',
      :target_id => 3522216)
  end

  def test_can_create_search_request
    url = URL_BASE +
      "action=search" + 
      "&api_key=rrc1d3ntb53tt6b2vhail6rdtrsxov3v" +
      "&auth_token=d2dqkrr6bae6ckua17osf9o1fhox9ypf" + 
      "&direction=asc" + 
      "&page=1" + 
      "&params[]=show_path" + 
      "&per_page=35" + 
      "&query=test" + 
      "&sort=relevance"

    Rubox::Parser.any_instance.stubs(:search)
    @rubox.expects(:http_get).with(url).returns(@response)
    @rubox.search(:auth_token => 'd2dqkrr6bae6ckua17osf9o1fhox9ypf',
      :query => 'test',
      :sort => 'relevance',
      :page => 1,
      :per_page => 35,
      :direction => 'asc',
      :params => 'show_path')
  end
end
