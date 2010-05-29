require "rubygems"
require "test/unit"
require "mocha"
require "rubox"

def assert_user_equal(a, b)
  attributes = %w[login           email         access_id 
                  user_id         space_amount  space_used 
                  max_upload_size]
  
  attributes.each do |attribute|
    assert_equal a.send(attribute), b.send(attribute)
  end
end
