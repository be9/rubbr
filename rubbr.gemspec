# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rubbr}
  s.version = "1.1.4.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Eivind Uggedal"]
  s.date = %q{2009-01-20}
  s.default_executable = %q{rubbr}
  s.description = %q{Build LaTeX documents.}
  s.email = %q{eu@redflavor.com}
  s.executables = ["rubbr"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  s.files = ["History.txt", "Manifest.txt", "README.txt", "Rakefile", "bin/rubbr", "lib/rubbr.rb", "lib/rubbr/builder.rb", "lib/rubbr/change.rb", "lib/rubbr/cli.rb", "lib/rubbr/options.rb", "lib/rubbr/runner.rb", "lib/rubbr/scm.rb", "lib/rubbr/spell.rb", "lib/rubbr/viewer.rb", "lib/rubbr/builder/tex.rb", "lib/rubbr/builder/ps.rb", "lib/rubbr/builder/dvi.rb", "lib/rubbr/runner/ps2pdf.rb", "lib/rubbr/runner/pdflatex.rb", "lib/rubbr/runner/latex.rb", "lib/rubbr/runner/dvips.rb", "lib/rubbr/runner/bibtex.rb", "lib/rubbr/scm/git.rb", "lib/rubbr/scm/subversion.rb", "lib/rubbr/scm/mercurial.rb", "lib/rubbr/viewer/ps.rb", "lib/rubbr/viewer/pdf.rb", "lib/rubbr/viewer/dvi.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://rubyforge.org/projects/rubbr/}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{rubbr}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{LaTeX builder}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<hoe>, [">= 1.8.2"])
    else
      s.add_dependency(%q<hoe>, [">= 1.8.2"])
    end
  else
    s.add_dependency(%q<hoe>, [">= 1.8.2"])
  end
end
