class GroupsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :find_user

  def index
    @groups = Group.where(user_id: @user.id)
  end

  def show
    @group = Group.find(params[:id])
    @payments = @group.payments
  end

  def new
    @group = Group.new
  end

  def create
    @group = @user.groups.new(group_params)
    if @group.save
      redirect_to groups_path(id: @group.id), notice: 'group created successfully'
    else
      render :new, status: 400
    end
  end

  private

  def find_user
    @user = current_user
  end

  def group_params
    params.require(:group).permit(:name, :icon)
  end
end
