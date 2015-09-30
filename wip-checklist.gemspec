# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wip/checklist/version'

Gem::Specification.new do |spec|
  spec.name          = "wip-checklist"
  spec.version       = WIP::Checklist::VERSION
  spec.authors       = ["Corey Innis"]
  spec.email         = ["corey@coolerator.net"]

  spec.summary       = "A CLI and console application for managing Github-backed checklists."
  spec.description   = "A CLI and console application for managing Github-backed checklists."
  spec.homepage      = "https://github.com/coreyti/wip-checklist"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "highline"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake",    "~> 10.0"
  spec.add_development_dependency "rspec",   "~> 3.3.0"
end
