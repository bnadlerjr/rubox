module Rubox
  # Implements a Box.net 'comment' object.
  class Comment
    # A unique identifier of the comment.  Can be used for other API calls 
    # (add_comment, delete_comment, etc).
    attr_accessor :comment_id

    # The comment's message.
    attr_accessor :message

    # The unique identifier of the user who wrote the comment.
    attr_accessor :user_id

    # The username of the user who wrote the comment.
    attr_accessor :user_name

    # A unix timestamp representing the time that the comment was made.
    attr_accessor :created

    # A URL of the user's profile picture.
    attr_accessor :avatar_url

    # Array of comments that are in reply to this comment.
    attr_accessor :reply_comments

    # Creates a new +Comment+ object.
    def initialize
      @reply_comments = []
      yield self if block_given?
    end

    # Builds a new +Comment+ object from an XML graph.
    #
    # xml:: The XML graph to build the +Comment+ object from.
    def self.build_from_xml(xml)
      xml['comment'].map do |element|
        Comment.new do |c|
          c.comment_id = element['comment_id'].to_i
          c.message = element['message']
          c.user_id = element['user_id'].to_i
          c.user_name = element['user_name']
          c.created = element['created'].to_i
          c.avatar_url = element['avatar_url']

          if element['reply_comments']
            element['reply_comments'].each do |reply|
              reply = reply[1]
              reply_comment = Comment.new do |rc|
                rc.comment_id = reply['comment_id'].to_i
                rc.message = reply['message']
                rc.user_id = reply['user_id'].to_i
                rc.user_name = reply['user_name']
                rc.created = reply['created'].to_i
                rc.avatar_url = reply['avatar_url']
              end
              c.reply_comments << reply_comment
            end
          end
        end
      end
    end
  end
end
