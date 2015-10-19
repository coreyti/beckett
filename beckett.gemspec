# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'beckett/version'

Gem::Specification.new do |spec|
  spec.name          = "beckett"
  spec.version       = Beckett::VERSION
  spec.authors       = ["Corey Innis"]
  spec.email         = ["corey@coolerator.net"]

  spec.summary       = "A Markdown-to-JSON/HTML5/Ruby-Hash Renderer."
  spec.description   = "A Markdown renderer, using Kramdown, to convert to JSON, HTML5 or a Ruby Hash."
  spec.homepage      = "https://github.com/coreyti/beckett"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "kramdown"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake",    "~> 10.0"
  spec.add_development_dependency "rspec",   "~> 3.3.0"
end
