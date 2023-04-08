class GroupsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :find_user

  def index
    @groups = Group.where(user_id: @user.id)
    @group_totals = @groups.to_h { |group| [group.id, group.payments.sum(:amount)] }
  end

  def show
    @group = Group.find(params[:id])
    @payments = @group.payments
    @payment_sum = @payments.sum(:amount)
  end

  def new
    @group = Group.new
  end

  def create
    @group = @user.groups.new(group_params)
    respond_to do |format|
      if @group.save
        format.html { redirect_to groups_path, notice: 'Category was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @group.destroy

    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
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