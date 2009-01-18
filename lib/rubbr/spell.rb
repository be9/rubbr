module Rubbr
  class Spell
    include Rubbr::Cli

    def check
      base_file_path = File.join(Rubbr.options[:source_dir],
                                 Rubbr.options[:base_latex_file])
      source_files = Dir["#{Rubbr.options[:source_dir]}/*.tex"]
      source_files.delete base_file_path

      dictionary_path = File.join(Rubbr.options[:spell_dir],
                                  Rubbr.options[:spell_file])
      executable = valid_executable(:ispell)

      source_files.each do |file|
        system "#{executable} -t -x -p #{dictionary_path} #{file}"
      end
    end
  end
end
