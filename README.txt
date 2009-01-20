= rubbr

* http://rubyforge.org/projects/rubbr/
* by Eivind Uggedal <eu@redflavor.com>

== DESCRIPTION:
  
Build LaTeX documents.

== SYNOPSIS:

Usage: rubbr [options]
  -f, --format [FORMAT]            Select output format (dvi, ps, pdf)
  -F, --force                      Force rebuild (even if files not changed)
  -e, --engine [ENGINE]            Select processing engine (latex, pdflatex)
  -d, --display                    Display the document
  -s, --spell                      Spell check source files
  -l, --loop                       Go into a build loop
  -D, --loop-delay [DELAY]         Set loop delay in seconds (default: 0.5)
  -v, --verbose                    Enable verbose feedback
  -V, --verboser                   Enable very verbose feedback
  -h, --help                       Show this help message

Standard project layout:

  root_dir         = Dir.pwd
  source_dir       = 'src'
  
  @defaults ||= {
    :root_dir          => File.pwd,
    :source_dir        => source_dir,
    :build_dir         => 'tmp',
    :distribution_dir  => 'dist',
    :template_file     => 'template.erb',
    :base_file         => 'base',
    :vendor_dir        => source_dir + '/vendor',
    :graphics_dir      => source_dir + '/graphics',
    :spell_dir         => source_dir,
    :spell_file        => 'dictionary.ispell',
    :distribution_name => distribution_name(root_dir),
    :loop_delay        => 0.5
  }

All these can be changed with a config.yml in the root_dir:

  ---
  build_dir: build
  graphics_dir: src/figures


== INSTALL:

gem install rubbr

== LICENSE:

(The MIT License)

Copyright (c) 2008 Eivind Uggedal <eu@redflavor.com>

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
