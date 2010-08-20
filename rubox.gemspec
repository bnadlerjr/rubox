$: << File.join(File.dirname(__FILE__), 'lib')
require 'rubox'

TITLE = 'Rubox'
MAIN_RDOC = 'README.rdoc'

TEST_FILES       = Dir['test/**/test_*.rb']
EXTRA_RDOC_FILES = ['README.rdoc', 'HISTORY.txt']

Gem::Specification.new do |spec|
  spec.author                = 'Bob Nadler, Jr.'
  spec.description           = 'A client library for the Box.net REST API.'
  spec.email                 = 'thethirdswitch [at] gmail'
  spec.extra_rdoc_files      = EXTRA_RDOC_FILES
  spec.files                 = `git ls-files`.split("\n") - ['.gitignore']
  spec.has_rdoc              = true
  spec.homepage              = 'http://bobnadler.com/rubox'
  spec.name                  = 'rubox'
  spec.required_ruby_version = '>=1.8.7'
  spec.test_files            = TEST_FILES
  spec.version               = Rubox::VERSION
  spec.rubyforge_project     = 'rubox' # required for validation

  spec.summary = <<-SUMMARY
Provides a client interface to the Box.net API. It relies on the REST version 
of the API, version 1.0. For a listing of available API calls see the 
documentation for the Box.net API which can be found at
http://developers.box.net/ApiOverview.
SUMMARY

  spec.rdoc_options << '--title' << TITLE <<
                       '--main' << MAIN_RDOC

  spec.add_dependency('xml-simple', '>=1.0.12')
  spec.add_development_dependency('rake', '>=0.8.7')
  spec.add_development_dependency('relevance-rov', '>=0.9.2.1')
  spec.add_development_dependency('mocha', '>=0.9.8')
end
