require "#{File.dirname(__FILE__)}/test_helper"

class TestFolder < Test::Unit::TestCase
  def test_can_build_from_xml
    xml = <<-XML
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
XML

    expected = Rubox::Folder.new do |f|
      f.folder_id = 4384
      f.name = "Incoming"
      f.shared = "0"
      f.tags = [34]
      f.files = [
        Rubox::File.new do |file|
          file.file_id = 68736
          file.file_name = "cows.w3g"
          file.shared = "0"
          file.size = 232386
          file.created = 1129537520
          file.updated = 1129537520
        end,
        Rubox::File.new do |file|
          file.file_id = 68737
          file.file_name = "silver.html"
          file.shared = "0"
          file.size = 15805
          file.created = 1129537520
          file.updated = 1129537520
          file.tags = [35]
        end
      ]
    end

    actual = 
      Rubox::Folder.build_from_xml(XmlSimple.xml_in(xml, 'ForceArray' => false))

    compare_folder expected, actual
  end
end
