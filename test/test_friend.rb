require "#{File.dirname(__FILE__)}/test_helper"

class TestFriend < Test::Unit::TestCase
  def test_can_build_from_xml
    xml = <<-XML
<friend>
<name>email2@example.com</name>
<email>email2@example.com</email>
<accepted>1</accepted>
<avatar_url>http://box.net/index.php?rm=box_user_avatar&user_id=398396&width=40&height=40&type=large</avatar_url>
<boxes>
<box>
<id>15</id>
<url>http://box.net/p/email2</url>
<status/>
</box>
</boxes>
</friend>
XML

    expected = Rubox::Friend.new do |f|
      f.name = 'email2@example.com'
      f.email = 'email2@example.com'
      f.accepted = 1
      f.avatar_url = 'http://box.net/index.php?rm=box_user_avatar' + 
        '&user_id=398396&width=40&height=40&type=large'
    end

    actual = 
      Rubox::Friend.build_from_xml(
        XmlSimple.xml_in(xml, 'ForceArray' => false))

    compare_friend expected, actual
  end
end
