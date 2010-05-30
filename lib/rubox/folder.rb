module Rubox
  # == Description
  # Implements a 'folder' object as specified here:
  # http://developers.box.net/Api+Object+-+Folder
  class Folder
    attr_accessor :id,          :name,   :user_id, 
                  :description, :shared, :shared_link, 
                  :permissions, :role,   :files, 
                  :folders,     :tags

    def initialize
      yield self if block_given?
    end
  end
end
