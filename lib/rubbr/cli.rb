module Rubbr

  # Handles command line output and input.
  module Cli
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
      STDOUT.reopen('/dev/null')
      yield
      STDOUT.reopen(old_stdout)
    end

    def disable_stderr
      old_stderr = STDERR.dup
      STDERR.reopen('/dev/null')
      yield
      STDERR.reopen(old_stderr)
    end

    def disable_stdinn
      old_stdinn = STDIN.dup
      STDIN.reopen('/dev/null')
      yield
      STDIN.reopen(old_stdinn)
    end

    def executable?(executable)
      disable_stdout do
        @existing = system("which #{executable}")
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
  end
end
