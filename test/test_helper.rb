require "rubygems"
require "test/unit"
require "mocha"
require "rubox"
require "pp"

def assert_user_equal(a, b)
  attributes = %w[login           email         access_id 
                  user_id         space_amount  space_used 
                  max_upload_size]
  
  attributes.each do |attribute|
    assert_equal a.send(attribute), b.send(attribute), "Failed on #{attribute}"
  end
end

def compare_file(expected, actual)
  %w[file_id file_name shared size created updated].each do |attribute|
    assert_equal expected.send(attribute), 
                 actual.send(attribute), 
                 "Failed on #{attribute}"
  end
end

def compare_folder(expected, actual)
  %w[folder_id name shared tags].each do |attribute|
    assert_equal expected.send(attribute), 
                 actual.send(attribute), 
                 "Failed on #{attribute}"
  end

  0.upto(expected.files.count-1) do |i|
    compare_file expected.files[i], actual.files[i]
  end
end

def compare_info(expected, actual)
  attributes = %w[file_id     file_name folder_id   shared 
                  shared_name size      description sha1 
                  created     updated]

  attributes.each do |attribute|
    assert_equal expected.send(attribute),
                 actual.send(attribute),
                 "Failed on #{attribute}"
  end
end

def compare_friend(expected, actual)
  attributes = %w[name email accepted avatar_url]
  attributes.each do |attribute|
    assert_equal expected.send(attribute),
                 actual.send(attribute),
                 "Failed on #{attribute}"
  end
end

def compare_comment(expected, actual)
  attributes = %w[comment_id message user_id user_name created avatar_url]
  attributes.each do |attribute|
    assert_equal expected.send(attribute),
                 actual.send(attribute),
                 "Failed on #{attribute}"
  end
end

def compare_search_result(expected, actual)
  attributes = %w[name search_id match_name match_description 
                  match_search_text]

  attributes.each do |attribute|
    assert_equal expected.send(attribute),
                 actual.send(attribute),
                 "Failed on #{attribute}"
  end
end
