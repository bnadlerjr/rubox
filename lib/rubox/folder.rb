module Rubox
  # == Description
  # Implements a Box.net 'folder' object as specified here:
  # http://developers.box.net/Api+Object+-+Folder
  class Folder
    # Unique indentifier for the folder. This can be used by applications for
    # other API methods (move, copy, upload, rename and more).
    attr_accessor :folder_id

    # The name of the folder.
    attr_accessor :name

    # The id of the user who owns the folder.
    attr_accessor :user_id

    # The folder's description. This can be empty.
    attr_accessor :description

    # Whether this folder is being shared with others to view. If the value is
    # 'densuv' that means that the user has full permissions. Each character 
    # represents a permission as follows:
    #   'd' - downloading rights
    #   'e' - delete rights
    #   'n' - rename rights
    #   's' - sharing rights
    #   'u' - upload rights
    #   'v' - viewing rights
    attr_accessor :shared

    # The user's role in this folder. Possible values can be:
    #   'owner'  - the folder was created and is owned by this user
    #   'editor' - the folder is owned by someone else, but this user has 
    #              editing rights
    #   'viewer' - the folder is owned by someone else, but this user is 
    #              permitted to view the content of the folder
    attr_accessor :role

    # An array of tag ids for this folder.
    attr_accessor :tags

    # An array of the folder's +File+'s.
    attr_accessor :files

    # An array of the folder's sub-folders.
    attr_accessor :folders

    # Creates a new +Folder+ object.
    def initialize
      yield self if block_given?
    end

    # Builds a new +Folder+ object from an XML graph.
    #
    # xml:: The XML graph to create the +Folder+ from.
    def self.build_from_xml(xml)
      Folder.new do |f|
        f.folder_id = xml['id'].to_i
        f.name = xml['name']
        f.shared = xml['shared']
        f.tags = [xml['tags']['tag']['id'].to_i] if xml['tags'] && xml['tags']['tag']

        if xml['files']['file'] && xml['files']['file'].count > 0
          f.files = xml['files']['file'].map { |f| File.build_from_xml(f) }
        end

        if xml['folders'] && xml['folders'].count > 0
          f.folders = xml['folders'].map { |f| Folder.build_from_xml(f[1]) }
        end
      end
    end
  end
end
