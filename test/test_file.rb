require "#{File.dirname(__FILE__)}/test_helper"

class TestFile < Test::Unit::TestCase
  def test_can_build_from_xml
    xml = <<-XML
<file id="68736" file_name="cows.w3g" keyword="" shared="0" size="232386"
created="1129537520" updated="1129537520">
<tags> </tags>
</file>
XML

    expected = Rubox::File.new do |f|
      f.file_id = 68736
      f.file_name = "cows.w3g"
      f.shared = "0"
      f.size = 232386
      f.created = 1129537520
      f.updated = 1129537520
    end

    actual = 
      Rubox::File.build_from_xml(XmlSimple.xml_in(xml, 'ForceArray' => false))

    compare_files expected, actual
  end
end
