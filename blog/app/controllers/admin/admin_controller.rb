class Admin::AdminController < ApplicationController
  layout 'admin'
  before_action :check_auth

  def check_auth
    redirect_to new_user_session_path unless user_signed_in? && current_user.role?(:admin)
  end
end
