require "#{File.dirname(__FILE__)}/test_helper"

class TestComment < Test::Unit::TestCase
  def test_can_build_from_xml
    xml = <<-XML
<comments>
    <comment>
      <comment_id>1108492</comment_id>
      <message>sample comment</message>
      <user_id>37135</user_id>
      <user_name>Example2</user_name>
      <created>1265632080</created>
      <avatar_url>https://ak3.boxcdn.net/resources/a8dkn0rr/img/box_user_avatar_large.png</avatar_url>
      <reply_comments>
        <item>
          <comment_id>1108498</comment_id>
          <message>sub-comment</message>
          <user_id>37131</user_id>
          <user_name>Example</user_name>
          <created>1265111091</created>
          <avatar_url>https://ak3.boxcdn.net/resources/a8dkn0ddd/img/box_user_avatar_large.png</avatar_url>
        </item>
      </reply_comments>
    </comment>
    <comment>
      <comment_id>1108494</comment_id>
      <message>sample</message>
      <user_id>37131</user_id>
      <user_name>Example</user_name>
      <created>1265661223</created>
      <avatar_url>https://ak3.boxcdn.net/resources/a8dkn0ddd/img/box_user_avatar_large.png</avatar_url>
    </comment>
  </comments>
XML

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

    actual = 
      Rubox::Comment.build_from_xml(XmlSimple.xml_in(xml, 
        'ForceArray' => false))

    expected.each_with_index do |exp, i|
      compare_comment exp, actual[i]
    end
  end
end

