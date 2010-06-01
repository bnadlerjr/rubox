module Rubox
  # == Description
  # Implements a Box.net 'user' object.
  class User
    # The user's username.
    attr_accessor :login

    # The user's email address.
    attr_accessor :email

    # If the user is guest, the +access_id+ will be the +user_id+ of the 
    # guest's parent. If this is a full user, the +access_id+ will be the same
    # as the +user_id+.
    attr_accessor :access_id

    # The unique id that Box.net associates with that user.
    attr_accessor :user_id

    # The total amount of space allocated to that account.
    attr_accessor :space_amount

    # The amount of space currently utilized by the user.
    attr_accessor :space_used

    # The maximum size in bytes for any individual file uploaded by the user.
    attr_accessor :max_upload_size

    # Creates a new +User+ object.
    def initialize
      yield self if block_given?
    end

    # Builds a new +User+ object from an XML graph.
    #
    # xml:: The XML graph to build from.
    def self.load_from_xml(xml)
      User.new do |u|
        u.login = xml['user']['login'].to_s
        u.email = xml['user']['email'].to_s
        u.access_id = xml['user']['access_id'].to_i
        u.user_id = xml['user']['user_id'].to_i
        u.space_amount = xml['user']['space_amount'].to_i
        u.space_used = xml['user']['space_used'].to_i
        u.max_upload_size = xml['user']['max_upload_size'].to_i
      end
    end
  end
end
