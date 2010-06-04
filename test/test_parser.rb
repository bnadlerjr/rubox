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

  def test_can_create_folder
    parser = Rubox::Parser.new(@responses['create_folder_response'])
    assert parser.create_folder
  end

  def test_can_move
    parser = Rubox::Parser.new(@responses['move_response'])
    assert parser.move
  end

  def test_can_copy
    parser = Rubox::Parser.new(@responses['copy_response'])
    assert parser.copy
  end

  def test_can_rename
    parser = Rubox::Parser.new(@responses['rename_response'])
    assert parser.rename
  end

  def test_can_delete
    parser = Rubox::Parser.new(@responses['delete_response'])
    assert parser.delete
  end

  def test_can_get_file_info
    parser = Rubox::Parser.new(@responses['get_file_info_response'])

    expected = Rubox::Info.new do |f|
      f.file_id = 224
      f.file_name = 'Box Press Release.doc'
      f.folder_id = 0
      f.shared = '0'
      f.size = 22528
      f.sha1 = '9a0bc49038c167151c544ac0b5fc9042335a41a3'
      f.created = 1182159570
      f.updated = 1182159571
    end

    compare_file expected, parser.get_file_info
  end

  def test_can_set_description
    parser = Rubox::Parser.new(@responses['set_description_response'])
    assert parser.set_description
  end

  def test_can_public_share
    parser = Rubox::Parser.new(@responses['public_share_response'])
    assert_equal 'ojf3i2n100', parser.public_share
  end

  def test_can_public_unshare
    parser = Rubox::Parser.new(@responses['public_unshare_response'])
    assert parser.public_unshare
  end

  def test_can_private_share
    parser = Rubox::Parser.new(@responses['private_share_response'])
    assert parser.private_share
  end

  def test_can_request_friends
    parser = Rubox::Parser.new(@responses['request_friends_response'])
    assert parser.request_friends
  end

  def test_can_get_friends
    expected = Rubox::Friend.new do |f|
        f.name = 'email2@example.com'
        f.email = 'email2@example.com'
        f.accepted = 1
        f.avatar_url = 'http://box.net/index.php?rm=box_user_avatar' + 
          '&user_id=398396&width=40&height=40&type=large'
    end

    parser = Rubox::Parser.new(@responses['get_friends_response'])
    actual = parser.get_friends

    assert actual.count == 1
    compare_friend expected, actual[0]
  end

  def test_can_add_to_mybox
    parser = Rubox::Parser.new(@responses['add_to_mybox_response'])
    assert parser.add_to_mybox
  end

  def test_can_add_to_tag
    parser = Rubox::Parser.new(@responses['add_to_tag_response'])
    assert parser.add_to_tag
  end

  def test_can_export_tags
    expected = [
      { :id => 37, :name => 'tag1' },
      { :id => 38, :name => 'tag2' }]

    parser = Rubox::Parser.new(@responses['export_tags_response'])
    assert_equal expected, parser.export_tags
  end

  def test_can_get_comments
    expected = [
      Rubox::Comment.new do |c|
        c.comment_id = 1108492
        c.message = 'sample comment'
        c.user_id = 37135
        c.user_name = 'Example2'
        c.created = 1265632080
        c.avatar_url = 'https://ak3.boxcdn.net/resources/a8dkn0rr/img/' + 
          'box_user_avatar_large.png'

        c.reply_comments = [
          Rubox::Comment.new do |rc|
            rc.comment_id = 1108498
            rc.message = 'sub-comment'
            rc.user_id = 37131
            rc.user_name = 'Example'
            rc.created = 1265111091
            rc.avatar_url = 'https://ak3.boxcdn.net/resources/a8dkn0ddd/' + 
              'img/box_user_avatar_large.png'
          end
        ]
      end,
      Rubox::Comment.new do |c|
        c.comment_id = 1108494
        c.message = 'sample'
        c.user_id = 37131
        c.user_name = 'Example'
        c.created = 1265661223
        c.avatar_url = 'https://ak3.boxcdn.net/resources/a8dkn0ddd/img/' + 
          'box_user_avatar_large.png'
      end
    ]

    parser = Rubox::Parser.new(@responses['get_comments_response'])
    actual = parser.get_comments

    expected.each_with_index do |exp, i|
      compare_comment exp, actual[i]
      exp.reply_comments.each_with_index do |reply, n|
        compare_comment reply, actual[i].reply_comments[n]
      end
    end
  end

  def test_can_add_comment
    parser = Rubox::Parser.new(@responses['add_comment_response'])
    assert parser.add_comment
  end
end
