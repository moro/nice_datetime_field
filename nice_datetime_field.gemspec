# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nice_datetime_field/version'

Gem::Specification.new do |gem|
  gem.name          = "nice_datetime_field"
  gem.version       = NiceDatetimeField::VERSION
  gem.authors       = ["moro"]
  gem.email         = ["moronatural@gmail.com"]
  gem.description   = %q{Provides nicely usable datetime field for Rails app.}
  gem.summary       = %q{Provides nicely usable datetime field for Rails app.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'actionpack'
end
