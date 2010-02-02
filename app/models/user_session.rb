class UserSession < Authlogic::Session::Base
  generalize_credentials_error_messages "Email/Password combination is not valid."
end
