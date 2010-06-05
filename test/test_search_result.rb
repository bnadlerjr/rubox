require "#{File.dirname(__FILE__)}/test_helper"

class TestSearchResult < Test::Unit::TestCase
  def test_can_build_from_folder_xml
    xml = <<-XML
<folders>
<folder>
<name>test_folder1</name>
<id>45225454</id>
<match_type>
<name>test-box</name>
<description/>
<search_text/>
</match_type>
</folder>
</folders>
XML

    expected = Rubox::SearchResult.new do |sr|
      sr.name = 'test_folder1'
      sr.search_id = 45225454
      sr.match_name = 'test-box'
    end

    actual = 
      Rubox::SearchResult.build_from_xml(
        XmlSimple.xml_in(xml, 'ForceArray' => false))

    compare_search_result expected, actual
  end

  def test_can_build_from_file_xml
    xml = <<-XML
<files>
<file>
<name>test1.doc</name>
<id>12325454</id>
<match_type>
<name/>
<description/>
<search_text>testing-is-cool</search_text>
</match_type>
</file>
</files>
XML

    expected = Rubox::SearchResult.new do |sr|
      sr.name = 'test1.doc'
      sr.search_id = 12325454
      sr.match_search_text = 'testing-is-cool'
    end

    actual = 
      Rubox::SearchResult.build_from_xml(
        XmlSimple.xml_in(xml, 'ForceArray' => false))

    compare_search_result expected, actual
  end
end
