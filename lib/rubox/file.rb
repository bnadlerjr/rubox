module Rubox
  # == Description
  # Implements a 'file' object. See 
  # http://developers.box.net/Api+Object+-+File for more information.
  class File
    attr_accessor :file_id, :file_name,   :user_id, :description, 
                  :shared,  :shared_link, :created, :updated, 
                  :size,    :tags

    def initialize
      yield self if block_given?
    end

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
