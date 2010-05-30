module Rubox
  # == Description
  # Implements a 'folder' object as specified here:
  # http://developers.box.net/Api+Object+-+Folder
  class Folder
    attr_accessor :folder_id,   :name,   :user_id, 
                  :description, :shared, :shared_link, 
                  :permissions, :role,   :files, 
                  :folders,     :tags

    def initialize
      yield self if block_given?
    end

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
