module Rubbr

  # Handles command line output and input.
  module Cli
    include Rubbr::OS

    def notice(message)
      puts color?(message, "\e[32m") if Rubbr.options[:verbose]
    end

    def warning(message)
      puts color?("  - #{message}", "\e[33m") if Rubbr.options[:verbose]
    end

    def error(message)
      puts color?("  * #{message}", "\e[31m")
    end

    def color?(msg, code)
      Rubbr.options[:color] ? "#{code}#{msg}\e[0m" : msg
    end

    def disable_stdout
      old_stdout = STDOUT.dup
      STDOUT.reopen(null_file)
      yield
      STDOUT.reopen(old_stdout)
    end

    def disable_stderr
      old_stderr = STDERR.dup
      STDERR.reopen(null_file)
      yield
      STDERR.reopen(old_stderr)
    end

    def disable_stdinn
      old_stdinn = STDIN.dup
      STDIN.reopen(null_file)
      yield
      STDIN.reopen(old_stdinn)
    end

    def executable?(executable)
      disable_stdout do
        @existing = system("#{which_cmd} #{executable}")
      end
      @existing
    end

    def valid_executable(executable)
      if executable?(executable)
        executable
      else
        error "Missing executable #{executable}"
        exit
      end
    end

    private

    def null_file
      case os
      when :windows
        'NUL'
      when :unix
        '/dev/null'
      end
    end

    def which_cmd
      case os
      when :windows
        'where'
      when :unix
        'which'
      end
    end
  end
end
