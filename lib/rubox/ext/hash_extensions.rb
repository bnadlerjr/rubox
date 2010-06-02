module Rubox
  # == Description
  # Utility functions that can be mixed into +Hash+ objects.
  module HashExtensions
    # Converts the +Hash+ into a querystring. The resulting querystring's keys
    # are sorted in alphabetical order.
    #
    # If one of the keys is +:params+, then it is assumed that the parameter 
    # is for an Array and '[]' will be appended to the key.
    #
    # === Example
    # { :foo => 1, :bar => 2, :baz => 3 }.to_querystring => "bar=2&baz=3&foo=1"
    # { :a => 1, :params => 'x,y,z' }.to_querystring => "a=1&params[]=x,y,z"
    def to_querystring
      sorted = self.sort { |a, b| a[0].to_s<=>b[0].to_s }
      sorted.map do |i|
        i[0] = "#{i[0]}[]" if 'params' == i[0].to_s
        "#{i[0]}=#{i[1]}"
      end.join('&')
    end
  end
end
