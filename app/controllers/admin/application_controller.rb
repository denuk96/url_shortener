module Admin
  class ApplicationController < ActionController::Base
    # TODO: set up with ENV["BASIC_AUTH_NAME"] & ENV["BASIC_AUTH_PASSWORD"]
    http_basic_authenticate_with name: "1", password: "1"

    layout "admin_dashboard"
  end
end
