class MembershipsController < ApplicationController

  before_action :logged_in_user
  before_action :admin_user

  def index
  	@memberships = Membership.all
  end

end
