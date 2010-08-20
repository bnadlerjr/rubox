require File.expand_path "#{File.dirname(__FILE__)}/test_helper"

class TestInfo < Test::Unit::TestCase
  def test_can_build_from_xml
    xml = <<-XML
<info>
<file_id>224</file_id>
<file_name>Box Press Release.doc</file_name>
<folder_id>0</folder_id>
<shared>0</shared>
<shared_name></shared_name>
<size>22528</size>
<description></description>
<sha1>9a0bc49038c167151c544ac0b5fc9042335a41a3</sha1>
<created>1182159570</created>
<updated>1182159571</updated>
</info>
XML

    expected = Rubox::Info.new do |i|
      i.file_id = 224
      i.file_name = 'Box Press Release.doc'
      i.folder_id = 0
      i.shared = '0'
      i.size = 22528
      i.sha1 = '9a0bc49038c167151c544ac0b5fc9042335a41a3'
      i.created = 1182159570
      i.updated = 1182159571
    end

    actual = 
      Rubox::Info.build_from_xml(XmlSimple.xml_in(xml, 'ForceArray' => false))

    compare_info expected, actual
  end
end
