# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rack/graylog2/version"

Gem::Specification.new do |s|
  s.name        = "rack-graylog2"
  s.version     = Rack::Graylog2::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Stephen Augenstein"]
  s.email       = ["perl.programmer@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Rack middleware for batching graylog logs by request}
  s.description = s.summary

  s.rubyforge_project = "rack-graylog2"

  s.add_dependency('gelf')

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
