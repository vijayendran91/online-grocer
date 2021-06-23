module Exceptions
  class AuthenticationError < StandardError; end
  class PasswordMismatch < AuthenticationError
    def initialize(msg)
      @error_msg = msg;
    end
  end
end
