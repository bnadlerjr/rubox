module Rubox
  module HashExtensions
    def to_querystring
      self.map { |k, v| "#{k}=#{v}" }.join('&')
    end
  end
end
