# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rubbr"

Gem::Specification.new do |s|
  s.name        = "be9-rubbr"
  s.version     = Rubbr::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Eivind Uggedal", "Oleg Dashevskii", "Vladimir Parfinenko"]
  s.email       = ["olegdashevskii@gmail.com"]
  s.homepage    = "http://github.com/be9/rubbr"
  s.summary     = %q{LaTeX builder}
  s.description = %q{Build LaTeX documents.}

  s.rubyforge_project = "rubbr"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
