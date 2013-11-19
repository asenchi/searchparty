# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'searchparty/version'

Gem::Specification.new do |spec|
  spec.name          = "searchparty"
  spec.version       = SearchParty::VERSION
  spec.authors       = ["Curt Micol"]
  spec.email         = ["asenchi@asenchi.com"]
  spec.description   = "Abstract queries for Splunk and similar services"
  spec.summary       = "Abstract queries for Splunk and similar services"
  spec.homepage      = "https://github.com/asenchi/searchparty"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rest-client"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "scrolls"
end
