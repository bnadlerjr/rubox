module Rubox
  # == Description
  # Utility functions that can be mixed into +Hash+.
  #
  # === Example
  # h = { :a => 1, :b => 2, :c => 3 }
  # h.extend(HashExtensions).to_querystring => "a=1&b=2&c=3"
  module HashExtensions
    # Converts the +Hash+ into a querystring.
    #
    # === Example
    # { :foo => 1, :bar => 2, :baz => 3 }.to_querystring => "foo=1&bar=2&baz=3"
    def to_querystring
      self.map { |k, v| "#{k}=#{v}" }.join('&')
    end
  end
end
