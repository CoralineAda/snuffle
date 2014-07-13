# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'snuffle/version'

Gem::Specification.new do |spec|
  spec.name          = "snuffle"
  spec.version       = Snuffle::VERSION
  spec.authors       = ["Coraline Ada Ehmke", "Kerri Miller"]
  spec.email         = ["coraline@idolhands.com"]
  spec.summary       = %q{Snuffle detects data clumps in your Ruby code.}
  spec.description   = %q{Snuffle detects data clumbs and other hints of extractable objects in your Ruby code.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "parser"
  spec.add_dependency "thor"
  spec.add_dependency "ephemeral", "~> 2.3.2"
  spec.add_dependency "poro_plus"
  spec.add_dependency "pearson"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "pry"

end
