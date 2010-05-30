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
  %w[file_id file_name shared size created updated].each do |attribute|
    assert_equal expected.send(attribute), 
                 actual.send(attribute), 
                 "Failed on #{attribute}"
  end
end

def compare_folders(expected, actual)
  %w[folder_id name shared tags].each do |attribute|
    assert_equal expected.send(attribute), 
                 actual.send(attribute), 
                 "Failed on #{attribute}"
  end

  0.upto(expected.files.count-1) do |i|
    compare_files expected.files[i], actual.files[i]
  end
  i=0
end
