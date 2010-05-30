module Rubox
  # == Description
  # Implements a 'file' object. See 
  # http://developers.box.net/Api+Object+-+File for more information.
  class File
    attr_accessor :id,     :file_name,   :user_id, :description, 
                  :shared, :shared_link, :created, :updated, 
                  :size,   :tags

    def initialize
      yield self if block_given?
    end
  end
end
