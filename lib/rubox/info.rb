module Rubox
  # == Description
  # Implements a Box.net 'info' object. See
  # http://developers.box.net/Api+Object+-+Info for more information.
  class Info
    # Unique identifier for the file.
    attr_accessor :file_id

    # The name of the file.
    attr_accessor :file_name

    # The +folder_id+ of the file's parent folder.
    attr_accessor :folder_id

    # Whether this file is being shared with others to view. +False+ means the
    # file is private. +True+ means the ile is shared and has an enabled 
    # +shared_link+.
    attr_accessor :shared

    # A unique identifier for the file, which can be used to generate a shared
    # page.
    attr_accessor :shared_name

    # Filesize in bytes.
    attr_accessor :size

    # The file's description. This can be empty.
    attr_accessor :description

    # According to Box.net API docs, this can be ignored. Implemented here for
    # completeness since it wasn't marked as deprecated.
    attr_accessor :sha1

    # A Unix timestamp for the time in which the file was created.
    attr_accessor :created

    # A Unix timestamp for the most recent time in which the file was updated.
    attr_accessor :updated

    # Creates a new +Info+ object.
    def initialize
      yield self if block_given?
    end

    # Builds a new +Info+ object from XML.
    #
    # xml:: The XML graph containing the info to build the object.
    def self.build_from_xml(xml)
      Info.new do |i|
        i.file_id     = xml['file_id'].to_i
        i.file_name   = xml['file_name']
        i.folder_id   = xml['folder_id'].to_i
        i.shared      = xml['shared']
#        i.shared_name = xml['shared_name']
        i.size        = xml['size'].to_i
#        i.description = xml['description']
        i.sha1        = xml['sha1']
        i.created     = xml['created'].to_i
        i.updated     = xml['updated'].to_i
      end
    end
  end
end
