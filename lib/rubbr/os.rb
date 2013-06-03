module Rubbr

  # Detection of OS.
  module OS
    def os
      if (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM)
        :windows
      else
        :unix
      end
    end
  end
end
