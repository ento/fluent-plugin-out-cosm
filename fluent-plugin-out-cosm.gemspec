# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.name          = "fluent-plugin-out-cosm"
  gem.version       = "0.1.0"
  gem.authors       = ["Marica Odagaki"]
  gem.email       = ["ento.entotto@gmail.com"]
  gem.summary       = %q{Fluentd output plugin for Cosm}
  gem.description   = gem.summary
  gem.homepage      = "https://github.com/ento/fluent-plugin-out-cosm"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "bundler"
  gem.add_development_dependency "json"
  gem.add_development_dependency "fluentd"
  gem.add_development_dependency "fluent-plugin-out-http"
  gem.add_runtime_dependency "fluentd"
  gem.add_runtime_dependency "fluent-plugin-out-http"
end
