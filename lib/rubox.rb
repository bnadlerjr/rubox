$:.unshift File.dirname(__FILE__)
require "rubox/ext/hash_extensions"
require "rubox/client"
require "rubox/user"
require "rubox/folder"
require "rubox/file"
require "rubox/info"
require "rubox/parser"
require "rubox/friend"
require "rubox/comment"
require "rubox/search_result"

module Rubox
  VERSION = '0.1.0'
end
