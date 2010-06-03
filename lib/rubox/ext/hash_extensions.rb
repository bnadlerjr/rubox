module Rubox
  # == Description
  # Utility functions that can be mixed into +Hash+ objects.
  module HashExtensions
    # Array of key names that should be treated as Array parameters.
    ARRAY_PARAMS = ['params', 'emails', 'tags']

    # Converts the +Hash+ into a querystring. The resulting querystring's keys
    # are sorted in alphabetical order.
    #
    # If one of the keys is specified in +ARRAY_PARAMS+ then the array is 
    # expanded and '[]' will be appended to the key.
    #
    # === Example
    # { :foo => 1, :bar => 2, :baz => 3 }.to_querystring => "bar=2&baz=3&foo=1"
    # { :a => 1, :params => ['x', 'y', 'z' }.to_querystring 
    #   => "a=1&params[]=x&params[]=y&params[]=z"
    def to_querystring
      sorted = self.sort { |a, b| a[0].to_s<=>b[0].to_s }
      sorted.map do |i|
        if ARRAY_PARAMS.include?(i[0].to_s)
          expand_array_parameter(i)
        else
          "#{i[0]}=#{i[1]}"
        end
      end.join('&')
    end

    private

    def expand_array_parameter(parameter)
      parameter[1].map { |p| "#{parameter[0]}[]=#{p}" }.join('&')
    end
  end
end
