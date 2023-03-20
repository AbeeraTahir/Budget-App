class GroupsController < ApplicationController
  before_action :set_user

  def index
    @groups = @user.groups.all
  end

  def new
    @group = Group.new
  end

  private

  def set_user
    @user = current_user
  end
end