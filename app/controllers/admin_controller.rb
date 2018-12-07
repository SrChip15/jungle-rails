class AdminController < ApplicationController

  before_action :admin_access

  private
    def admin_access
      authenticate_or_request_with_http_basic do |username, password|
        username == ENV['AUTHENTICATE_USERNAME'] &&
        password == ENV['AUTHENTICATE_PASSWORD']
      end
    end

end
