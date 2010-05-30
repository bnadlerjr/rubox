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

    @rubox.stubs(:http_get).returns(response)
    file1 = Rubox::File.new do |f|
      f.id = 68736
      f.file_name = 'cows.w3g'
      f.shared = '0'
      f.size = 232386
      f.created = 1129537520
      f.updated = 1129537520
    end

    file2 = Rubox::File.new do |f|
      f.id = 68737
      f.file_name = 'silver.html'
      f.shared = '0'
      f.size = 15805
      f.created = 1129537520
      f.updated = 1129537520
      f.tags = [35]
    end

    subfolder = Rubox::Folder.new do |f|
      f.id = 4384
      f.name = "Incoming"
      f.shared = '0'
      f.tags = [34]
      f.files = [file1, file2]
    end

    main_folder = Rubox::Folder.new do |f|
      f.id = 0
      f.shared = '0'
      f.folders = [subfolder]
    end

    tree = @rubox.get_account_tree
#    puts tree.folders['folder'].inspect
#    assert_equal file1, tree.folders[0].files[0]
  end
end
