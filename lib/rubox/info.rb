module Rubox
  class Info
    attr_accessor :file_id,     :file_name,   :folder_id,
                  :shared,      :shared_name, :size,
                  :description, :sha1,        :created,
                  :updated

    def initialize
      yield self if block_given?
    end

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
