# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cuatrocientoscuatro/version'

Gem::Specification.new do |spec|
  spec.name          = "cuatrocientoscuatro"
  spec.version       = Cuatrocientoscuatro::VERSION
  spec.authors       = ["Miles Starkenburg"]
  spec.email         = ["milesstarkenburg@gmail.com"]
  spec.summary       = %q{Simple Http file server that responds in español.}
  spec.description   = %q{Very simple http server following https://practicingruby.com/articles/implementing-an-http-file-server?u=2c59db4496 as a guide}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
