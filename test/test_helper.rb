require "rubygems"
require "test/unit"
require "mocha"
require "rubox"

def assert_user_equal(a, b)
  attributes = %w[login           email         access_id 
                  user_id         space_amount  space_used 
                  max_upload_size]
  
  attributes.each do |attribute|
    assert_equal a.send(attribute), b.send(attribute), "Failed on #{attribute}"
  end
end

def compare_files(expected, actual)
  attributes = %w[file_id file_name shared size created updated]

  attributes.each do |attribute|
    assert_equal expected.send(attribute), actual.send(attribute), "Failed on #{attribute}"
  end
end

def compare_folders(expected, actual)
  attributes = %w[folder_id name shared tags]

  attributes.each do |attribute|
    assert_equal expected.send(attribute), actual.send(attribute), attribute
  end

  i=0
  while i < expected.files.count
    compare_files expected.files[i], actual.files[i]
    i += 1
  end
end
