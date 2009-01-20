module Rubbr

  # Extracts changeset stats from various SCM systems. This info can be
  # included in the title page of the latex document and is especially helpful
  # when working with draft versions.
  module Scm
    class Base
      include Rubbr::Cli

      # The name of the SCM system. 
      attr_accessor :name

      # The Mercurial executable.
      attr_accessor :executable

      # The revision and date of the tip/head/latest changeset.
      attr_accessor :revision, :date

      def collect_scm_stats
        { :name => @name,
          :revision => @revision,
          :date => @date }
      end
    end

    def self.stats(dir)
      {
        '.svn' => Rubbr::Scm::Subversion,
        '.hg'  => Rubbr::Scm::Mercurial,
        '.git' => Rubbr::Scm::Git
      }.each do |ext, klass|
        if File.exists? File.join(dir, ext)
          return klass.new.collect_scm_stats
        end
      end

      nil
    end

    %w(mercurial subversion git).each do
      |f| require File.dirname(__FILE__) + "/scm/#{f}"
    end
  end
end
