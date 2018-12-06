class Admin::DashboardController < ApplicationController

  before_filter :admin_access

  def show
  end

end
