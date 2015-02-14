# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rummy/version'

Gem::Specification.new do |spec|
  spec.name          = "rummy"
  spec.version       = Rummy::VERSION
  spec.authors       = ["Taylor Raack", "Tingting Huang"]
  spec.email         = ["taylor@raack.info", "stairwaytth@gmail.com"]
  spec.summary       = %q{Rummy card game strategy experimentation framework}
  spec.description   = %q{Rummy card game strategy experimentation framework}
  spec.homepage      = ""
  spec.license       = "AGPLv3"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
