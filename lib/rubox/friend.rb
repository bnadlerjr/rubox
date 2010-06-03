module Rubox
  # == Description
  # Implements a Box.net 'friend' object. 
  #
  # === Note
  # According to http://developers.box.net/ApiFunction_get_friends the 
  # 'boxes' attribute is an outdated feature. Therefore it is not implemented 
  # here.
  class Friend
    # The Box.net username. Upon registering this is the user's email address 
    # by default, but user's often change this in Settings.
    attr_accessor :name

    # The user's email address.
    attr_accessor :email

    # The number of folders on which this friend has accepted a collaboration 
    # inivitation from the user.
    attr_accessor :accepted

    # A URL of the user's profile picture.
    attr_accessor :avatar_url

    # Creates a new +Friend+ object.
    def initialize
      yield self if block_given?
    end

    # Builds a new +Friend+ object from an XML graph.
    #
    # xml:: The XML graph to create the +Friend+ from.
    def self.build_from_xml(xml)
      Friend.new do |f|
        f.name = xml['name']
        f.email = xml['email']
        f.accepted = xml['accepted'].to_i
        f.avatar_url = xml['avatar_url']
      end
    end
  end
end
