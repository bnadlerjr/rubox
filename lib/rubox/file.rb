module Rubox
  # == Description
  # Implements a Box.net 'file' object. See 
  # http://developers.box.net/Api+Object+-+File for more information.
  class File
    # Unique identifer for the file.
    attr_accessor :file_id

    # The name of the file.
    attr_accessor :file_name

    # The id of the user who created the file.
    attr_accessor :user_id

    # The file's description. This can be empty.
    attr_accessor :description

    # Whether this file is being shared with others to view. +False+ means the
    # file is private. +True+ means the file is shared and has an enabled
    # +shared_link+.
    attr_accessor :shared

    # A URL to share with others to view the file.
    attr_accessor :shared_link

    # A Unix timestamp fo the time in which the file was created.
    attr_accessor :created

    # A Unix timestamp for the most recent time in which the file was updated.
    attr_accessor :updated

    # The size of the file in bytes.
    attr_accessor :size

    # An array of the +File+'s tag ids.
    attr_accessor :tags

    # Creates a new +File+ object.
    def initialize
      yield self if block_given?
    end

    # Builds a new +File+ object from an XML graph.
    #
    # xml:: The XML graph to build the +File+ object from.
    def self.build_from_xml(xml)
      File.new do |f|
        f.file_id = xml['id'].to_i
        f.file_name = xml['file_name']
        f.user_id = xml['user_id']
        f.description = xml['description']
        f.shared = xml['shared']
        f.shared_link = xml['shared_link']
        f.created = xml['created'].to_i
        f.updated = xml['updated'].to_i
        f.size = xml['size'].to_i
        f.tags = [xml['tags']['tag']['id'].to_i] if xml['tags']['tag']
      end
    end
  end
end
