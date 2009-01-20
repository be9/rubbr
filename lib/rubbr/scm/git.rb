module Rubbr

  # Extracts changeset stats from various SCM systems. This info can be
  # included in the title page of the latex document and is especially helpful
  # when working with draft versions.
  module Scm
    class Git < Base

      def initialize
        super

        @name = 'Git'
        @executable = valid_executable :git

        @revision, @date = parse_scm_stats

        yield self if block_given?
      end

      def parse_scm_stats
        return [nil, nil] unless @executable

        raw_stats = `#@executable show --abbrev-commit --pretty=medium HEAD`
        revision = raw_stats.scan(/^commit ([0-9a-f]+)/).first.first
        date = raw_stats.scan(/^Date: +(.+)/).first.first

        [revision, date]
      end
    end
  end
end

