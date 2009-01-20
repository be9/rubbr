module Rubbr
  class Options
    class << self
      include Rubbr::Cli
      def defaults
        root_dir         = Dir.pwd
        source_dir       = 'src'

        @defaults ||= {
          :root_dir          => root_dir,
          :source_dir        => source_dir,
          :build_dir         => 'tmp',
          :distribution_dir  => 'dist',
          :base_file         => 'base',
          :vendor_dir        => source_dir + '/vendor',
          :graphics_dir      => source_dir + '/graphics',
          :spell_dir         => source_dir,
          :spell_file        => 'dictionary.ispell',
          :inventory_file    => '.inventory',
          :distribution_name => distribution_name(root_dir),
          :verbose           => false,
          :verboser          => false,
          :color             => false,
          :format            => :dvi,
          :engine            => :latex,
          :loop_delay        => 0.5
        }
      end

      # Fetching options from a config file if present and merges it
      # with the defaults.
      def setup
        preference_file = "#{defaults[:root_dir]}/config.yml"
        preferences = {}
        if File.exists? preference_file
          require 'yaml'
          File.open(preference_file) { |file| preferences = YAML.load(file) }
        end
        base_file_variations(absolute_paths(defaults.merge(preferences)))
      end

      private

        def distribution_name(root)
          name = File.basename(root)
          name << ".#{user_name}"
          if stats = Rubbr::Scm.stats(root)
            name << ".r#{stats[:revision].gsub(':', '_')}"
          end
          name
        end

        def user_name
          `whoami`.strip
        end

        def absolute_paths(options)
          options.each_key do |key|
            if key.to_s =~ /\w+_dir/ && key != :root_dir
              options[key.to_sym] = File.join(options[:root_dir],
                                              options[key.to_sym])
            end
          end
          options
        end

        def base_file_variations(options)
          options[:base_latex_file]  = options[:base_file] + '.tex'
          options[:base_bibtex_file] = options[:base_file] + '.aux'
          options[:base_dvi_file]    = options[:base_file] + '.dvi'
          options[:base_ps_file]     = options[:base_file] + '.ps'
          options[:base_pdf_file]    = options[:base_file] + '.pdf'
          options
        end
    end
  end
end
