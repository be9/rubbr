module Rubbr
  module Builder
    class Tex < Base
      class << self
        def build

          clean_build_dir

          base_latex_file = Rubbr.options[:base_latex_file]
          base_bibtex_file = Rubbr.options[:base_bibtex_file]

          case Rubbr.options[:engine]
          when :pdflatex
            @output_format = :pdf
            preprocessor = Rubbr::Runner::PdfLaTeX
          else
            @output_format = :dvi
            preprocessor = Rubbr::Runner::LaTeX
          end

          build_dir do
            copy_source_files
            copy_vendor_files
            copy_graphic_files

            # first run
            latex = preprocessor.new(base_latex_file)

            if base_bibtex_file && latex.warnings.join =~ /No file .+\.bbl/
              bibtex = Rubbr::Runner::BibTeX.new(base_bibtex_file)
            end

            if latex.warnings.join =~ /No file .+\.(aux|toc)/
              latex = preprocessor.new(base_latex_file)
            end

            if latex.warnings.join =~ /There were undefined citations/
              latex = preprocessor.new(base_latex_file)
            end

            if latex.warnings.join =~ /Label\(s\) may have changed\. Rerun/
              latex = preprocessor.new(base_latex_file)
            end

            # last run needed to get lof to be proper
            latex = preprocessor.new(base_latex_file)

            latex.feedback
            if bibtex
              bibtex.feedback
            end
          end
          distribute_file(base_latex_file)
          notice "Build of #@output_format completed for: #{base_latex_file} " +
                 "in #{Rubbr.options[:build_dir]}"
        end

        private

          def clean_build_dir
            if File.exists? Rubbr.options[:build_dir]
              FileUtils.rm_r Rubbr.options[:build_dir]
            end
          end

          def copy_source_files
            copy_files(Rubbr.options[:source_dir], %w(tex bib cls))
          end

          def copy_vendor_files
            copy_files(Rubbr.options[:vendor_dir], %w(sty clo cls cfg bst rtx))
          end

          def copy_graphic_files
            copy_files(Rubbr.options[:graphics_dir], %w(eps mps png))
          end

          def copy_files(source_dir, file_extensions)
            file_extensions.each do |file_extension|
              Dir["#{source_dir}/*.#{file_extension}"].each do |file|
                FileUtils.cp(file,  Rubbr.options[:build_dir])
              end
            end
          end
      end
    end
  end
end
