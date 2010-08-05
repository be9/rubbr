require 'rubygems'
require 'hoe'
require 'spec/rake/spectask'
require './lib/rubbr.rb'

Hoe.new('be9-rubbr', Rubbr::VERSION) do |p|
#  p.rubyforge_name = 'rubbr'
  p.author = 'Eivind Uggedal'
  p.email = 'eu@redflavor.com'
  p.summary = 'LaTeX builder'
  # p.description = p.paragraphs_of('README.txt', 2..5).join("\n\n")
  # p.url = p.paragraphs_of('README.txt', 0).first.split(/\n/)[1..-1]
  p.changes = p.paragraphs_of('History.txt', 0..1).join("\n\n")
  p.remote_rdoc_dir = ''
end

desc "Run all specs"
Spec::Rake::SpecTask.new('specs') do |t|
  t.spec_opts = ["--format", "specdoc", "--colour"]
  t.spec_files = Dir['specs/*_spec.rb'].sort
end

task :cultivate do
  system "touch Manifest.txt; rake check_manifest | grep -v \"(in \" | patch"
  system "rake debug_gem | grep -v \"(in \" > `basename \\`pwd\\``.gemspec"
end
