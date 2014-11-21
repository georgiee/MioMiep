# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require 'miomiep/version'

Gem::Specification.new do |gem|
  gem.name        = "miomiep"
  gem.summary     = "miomiep summary"
  gem.description = "miomiep description"
  gem.licenses    = ['MIT']
  gem.homepage    = "http://github.com/miomiep"
  gem.version     = MioMiep::VERSION

  gem.authors     = ["Georgios Kaleadis"]
  gem.email       = "georgios@kaleadis.de"

  gem.require_paths  = ["lib"]
  gem.files          = `git ls-files`.split("\n")
  gem.test_files     = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables    = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }

  gem.extra_rdoc_files = ["readme.md"]
  gem.rdoc_options     = ["--line-numbers", "--inline-source", "--title", "Miomiep"]
end
