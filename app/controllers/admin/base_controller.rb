# new file created pg 218
# app/controllers/admin/base_controller.rb


class Admin::BaseController < ApplicationController
  before_filter :authorize_admin!
end
