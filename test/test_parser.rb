require "yaml"
require "#{File.dirname(__FILE__)}/test_helper"

class TestParser < Test::Unit::TestCase
  def setup
    response_file = File.join(File.dirname(__FILE__), 'data/responses.yml')
    @responses = File.open(response_file) { |y| YAML::load(y) }
  end

  # Authentication Tests
  def test_can_get_ticket
    parser = Rubox::Parser.new(@responses['ticket_response'])
    assert_equal "bxquuv025arztljze2n438md9zef95e8", parser.get_ticket
  end

  def test_can_get_auth_token
    parser = Rubox::Parser.new(@responses['auth_token_response'])
    assert_equal "9byo5bg8d2o3otp0voji0ej0v49bqcmo", parser.get_auth_token
  end

  def test_can_logout
    parser = Rubox::Parser.new(@responses['logout_response'])
    assert parser.logout
  end

  def test_can_register_new_user
    parser = Rubox::Parser.new(@responses['register_response'])
    assert parser.register_new_user
  end

  def test_can_verify_registration_email
    parser = Rubox::Parser.new(@responses['email_response'])
    assert parser.verify_registration_email
  end

  def test_can_get_account_info
    parser = Rubox::Parser.new(@responses['account_response'])
    expected = Rubox::User.new do |u|
      u.login = 'email@example.com'
      u.email = 'email@example.com'
      u.access_id = 398387
      u.user_id = 398387
      u.space_amount = 1073741824
      u.space_used = 0
      u.max_upload_size = 2147483648
    end

    assert_user_equal expected, parser.get_account_info
  end

  # File & Folder Operations
  def test_can_get_account_tree
      expected = Rubox::Folder.new do |f|
      f.name = ''
      f.folder_id = 0
      f.shared = '0'
      f.folders = [
        Rubox::Folder.new do |f|
          f.folder_id = 4384
          f.name = "Incoming"
          f.shared = '0'
          f.tags = [34]
          f.files = [
            file1 = Rubox::File.new do |f|
              f.file_id = 68736
              f.file_name = 'cows.w3g'
              f.shared = '0'
              f.size = 232386
              f.created = 1129537520
              f.updated = 1129537520
            end,
            file2 = Rubox::File.new do |f|
              f.file_id = 68737
              f.file_name = 'silver.html'
              f.shared = '0'
              f.size = 15805
              f.created = 1129537520
              f.updated = 1129537520
              f.tags = [35]
            end
          ]
        end
      ]
    end
    
    tree = 
      Rubox::Parser.new(@responses['account_tree_response']).get_account_tree

    assert_equal expected.name, tree.name
    assert_equal expected.folder_id, tree.folder_id
    assert_equal expected.shared, tree.shared

    compare_folder expected.folders[0], tree.folders[0]
  end

end
