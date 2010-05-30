require "#{File.dirname(__FILE__)}/test_helper"

class TestFileFolderApi < Test::Unit::TestCase
  def setup
    @rubox = Rubox::Client.new('api_token')
  end

  def test_can_get_account_tree
    response = <<-RESP
<?xml version='1.0' encoding='UTF-8'?>
<response>
<status>listing_ok</status>
<tree>
<folder id="0" name="" shared="0">
<tags></tags>
<files></files>
<folders>
<folder id="4384" name="Incoming" shared="0">
<tags>
<tag id="34" />
</tags>
<files>
<file id="68736" file_name="cows.w3g" keyword="" shared="0" size="232386"
created="1129537520" updated="1129537520">
<tags> </tags>
</file>
<file id="68737" file_name="silver.html" keyword="" shared="0" size="15805"
created="1129537520" updated="1129537520">
<tags>
<tag id="35" />
</tags>
</file>
</files>
</folder>
</folders>
</folder>
</tree>
</response>
RESP

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
    
    @rubox.stubs(:http_get).returns(response)
    tree = @rubox.get_account_tree

    assert_equal expected.name, tree.name
    assert_equal expected.folder_id, tree.folder_id
    assert_equal expected.shared, tree.shared

    compare_folder expected.folders[0], tree.folders[0]
  end
end
