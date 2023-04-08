class PaymentsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :find_user

  def index 
    @group_uniq = Group.find(params[:group_id])
    @payments = Payment.where(author_id: @user.id).order(created_at: :desc)
    @group = Payment.order(created_at: :desc).joins(:groups).pluck(:'groups.icon')
    @payment_sum = @payments.sum(:amount)
  end

  def show 
    @payment = Payment.find(params[:id])
    @group = Group.find(params[:group_id])
  end

  def new 
    @group = Group.find(params[:group_id])
    @payment = Payment.new
  end

  def create
    @payment = Payment.new(payment_params)
    @payment.author_id = @user.id
    @payment.groups = Group.where(id: params[:payment][:group_ids]).includes([:user])
    if @payment.save
      redirect_to group_path(id: params[:payment][:group_ids].last), notice: 'Payment was successfully created.'
    else
      render :new, notice: 'Error not saved'
    end
  end

  def destory
    @group_uniq = Group.find(params[:group_id])
    @payment = Payment.find(params[:id])
    if @payment.destroy
      redirect_to group_path(@group_uniq), notice: 'Payment was successfully deleted.'
    else
      render :new, notice: 'Error not deleted'
    end
  end

  private

  def find_user
    @user = current_user
  end

  def payment_params
    params.require(:payment).permit(:name, :amount, group_ids: [])
  end
end
