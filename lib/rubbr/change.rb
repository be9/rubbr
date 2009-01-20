module Rubbr

  # Checks if source files have changed since last time they was accessed by
  # computing and storing a hash of their contents.
  class Change
    extend Rubbr::Cli
    require 'digest/md5'
    require 'yaml'

    def self.d?
      sums = inventory
      if changes?(sums)
        write_inventory sums
        true
      else
        if Rubbr.options[:force]
          notice "No changes in #{Rubbr.options[:build_dir]} since last build, building anyway (--force)"
          true
        else 
          notice "No changes in #{Rubbr.options[:build_dir]} since last build"
          false
        end
      end
    end

    private

      def self.inventory
        source_files = Dir["#{Rubbr.options[:source_dir]}/*.tex"]
        source_files.collect do |f|
          [f, digest(File.read(f))]
        end
      end

      def self.write_inventory(sums)
        File.open(Rubbr.options[:inventory_file], 'w') do |f|
          f.write(sums.to_yaml)
        end
      end

      def self.read_inventory
        YAML.load_file(Rubbr.options[:inventory_file])
      end

      def self.changes?(sums)
        return true unless File.exists?(Rubbr.options[:inventory_file])
        sums != read_inventory
      end

      def self.digest(contents)
        Digest::MD5.hexdigest contents
      end
  end
end
