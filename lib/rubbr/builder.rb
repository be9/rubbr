require 'fileutils'

module Rubbr

  # Handles the business of building latex (and bibtex if needed) source
  # files into binary formats as dvi, ps, and pdf. The latex and bibtex
  # utilites need to be run a certain number of times so that things like
  # table of contents, references, citations, etc become proper. This module
  # tries to solve this issue by running the needed utilities only as many
  # times as needed.
  module Builder
    extend Rubbr::Cli

    # Build to the spesified format.
    def self.build
      if Rubbr::Change.d?
        do_build
      elsif Rubbr.options[:force]
        notice "No changes in #{Rubbr.options[:build_dir]} since last build, building anyway (--force)"
        do_build
      else 
        notice "No changes in #{Rubbr.options[:build_dir]} since last build"
        true
      end
    end

    def self.build_in_a_loop
      delay = Rubbr.options[:loop_delay]
      delay = 0.5 if delay == 0.0

      notice "Entering build loop. Press Ctrl-C to break out."

      forced_first_time = Rubbr.options[:force]

      while true
        if Rubbr::Change.d? || forced_first_time
          notice "Change detected, building"

          forced_first_time = false

          do_build
        end

        sleep delay
      end
    end

    def self.do_build
      if Rubbr.options[:engine] == :pdflatex
        Rubbr::Builder::Tex.build
      else
        case Rubbr.options[:format]
        when :dvi
          Rubbr::Builder::Tex.build
        when :ps
          Rubbr::Builder::Tex.build
          Rubbr::Builder::Dvi.build
        else
          Rubbr::Builder::Tex.build
          Rubbr::Builder::Dvi.build
          Rubbr::Builder::Ps.build
        end
      end

      true
    rescue Rubbr::Runner::GotErrors
      notice "There were errors, processing stopped."

      false
    end

    class Base
      class << self
        include Rubbr::Cli

        protected

          def build_dir
            prepare_dir(Rubbr.options[:build_dir]) do
              yield
            end
          end

          def distribute_file(base_file)
            prepare_dir(Rubbr.options[:distribution_dir]) do
              FileUtils.cp(File.join(Rubbr.options[:build_dir],
                           "#{base_file.gsub(/.\w+$/, '')}.#@output_format"),
                 File.join(Rubbr.options[:distribution_dir],
                           Rubbr.options[:distribution_name] +
                           ".#@output_format"))
            end
          end

          def prepare_dir(dir)
            if dir
              FileUtils.mkdir_p dir unless File.exists? dir
              FileUtils.cd dir do
                yield
              end
            else
              yield
            end
          end
      end
    end

    %w(tex dvi ps).each do
      |f| require File.dirname(__FILE__) + "/builder/#{f}"
    end
  end
end

