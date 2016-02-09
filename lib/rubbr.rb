require 'optparse'
$:.unshift File.dirname(__FILE__)

module Rubbr
  VERSION = '1.1.7'

  autoload :Options,       'rubbr/options'
  autoload :OS,            'rubbr/os'
  autoload :Cli,           'rubbr/cli'
  autoload :Config,        'rubbr/config'
  autoload :Scm,           'rubbr/scm'
  autoload :Change,        'rubbr/change'
  autoload :Runner,        'rubbr/runner'
  autoload :Builder,       'rubbr/builder'
  autoload :Viewer,        'rubbr/viewer'
  autoload :Spell,         'rubbr/spell'

  class << self
    @@cmd_opts = {}

    def options
      @@global_opts ||= Rubbr::Options.setup.merge(@@cmd_opts)
    end

    def run(args = ARGV)
      opts = OptionParser.new do |opts|
        opts.version = Rubbr::VERSION
        opts.banner = 'Usage: rubbr [options]'

        opts.on('-f', '--format [FORMAT]', [:dvi, :ps, :pdf],
          'Select output format (dvi, ps, pdf)') do |format|
          @@cmd_opts[:format] = format
        end

        opts.on('-F', '--force', 'Force rebuild (even if files not changed)') do
          @@cmd_opts[:force] = true
        end

        opts.on('-e', '--engine [ENGINE]', [:latex, :pdflatex, :xelatex],
          'Select processing engine (latex, pdflatex, xelatex)') do |engine|
          @@cmd_opts[:engine] = engine
        end

        opts.on('-n', '--distribution-name NAME', String, 'Set distribution name') do |name|
          @@cmd_opts[:distribution_name] = name
        end

        opts.on('-d', '--display', 'Display the document') do
          @@cmd_opts[:view] = true
        end

        opts.on('-s', '--spell', 'Spell check source files') do
          @@cmd_opts[:spell] = true
        end

        opts.on('-l', '--loop', 'Go into a build loop') do
          @@cmd_opts[:loop] = true
        end

        opts.on('-D', '--loop-delay [DELAY]', Float, 'Set loop delay in seconds (default: 0.5)') do |delay|
          @@cmd_opts[:loop_delay] = delay
        end

        opts.on('-v', '--verbose', 'Enable verbose feedback') do
          @@cmd_opts[:verbose] = true
        end

        opts.on('-V', '--verboser', 'Enable verbose feedback for hboxes') do
          @@cmd_opts[:verbose] = true
          @@cmd_opts[:verboser] = true
        end

        opts.on('-c', '--color', 'Enable colorized feedback') do
          @@cmd_opts[:color] = true
        end

        opts.on('-h', '--help', 'Show this help message') do
          puts opts
          exit 1
        end
      end

      begin
        opts.parse!(args)
      rescue OptionParser::ParseError
        puts opts
        exit 1
      end

      case
      when @@cmd_opts[:spell]
        Rubbr::Spell.new.check

      when @@cmd_opts[:view]
        exit 2 unless Rubbr::Builder.build
        Rubbr::Viewer.view

      when @@cmd_opts[:loop]
        Rubbr::Builder.build_in_a_loop

      else
        exit 2 unless Rubbr::Builder.build
      end
    end
  end
end
