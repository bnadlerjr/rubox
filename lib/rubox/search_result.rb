module Rubox
  class SearchResult
    # Name of the file or folder that matches the search criteria.
    attr_accessor :name

    # Unique identifier of the file or folder that matches the search 
    # criteria.
    attr_accessor :search_id

    # Source of the match between the file or folder and the search 
    # criteria.
    attr_accessor :match_name
    attr_accessor :match_description
    attr_accessor :match_search_text

    # Creates a new +SearchResult+ object.
    def initialize
      yield self if block_given?
    end

    # Creates a new +SearchResult+ object from an XML graph.
    #
    # xml:: The XML graph to create the +SearchResult+ from.
    def self.build_from_xml(xml)
      xml['folder'] ? parent = xml['folder'] : parent = xml['file']

      SearchResult.new do |sr|
        sr.name = parent['name']
        sr.search_id = parent['id'].to_i
        
        unless parent['match_type']['name'].empty?
          sr.match_name = parent['match_type']['name']
        end
        unless parent['match_type']['description'].empty?
          sr.match_description = parent['match_type']['description']
        end
        unless parent['match_type']['search_text'].empty?
          sr.match_search_text = parent['match_type']['search_text']
        end
      end
    end
  end
end
