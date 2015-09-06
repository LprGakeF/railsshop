class OrderedItemsController < ApplicationController
  before_action :set_ordered_item, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_customer!
  before_action :check_admin, only: [:new, :create, :destroy]

  # GET /ordered_items
  # GET /ordered_items.json
  def index
    if current_customer.admin?
      @ordered_items = OrderedItem.all
    else
      @ordered_items = OrderedItem.all.where(:customer_id => current_customer.id)
    end
  end

  # GET /ordered_items/1
  # GET /ordered_items/1.json
  def show
  end

  # GET /ordered_items/new
  def new
    @ordered_item = OrderedItem.new
  end

  # GET /ordered_items/1/edit
  def edit
  end

  # POST /ordered_items
  # POST /ordered_items.json
  def create

    if (current_customer.try(:admin?))
      current_params = ordered_item_params
    else
      current_params = ordered_item_params_restricted_for_customer
    end

    current_params[:customer_id] = current_customer.id
    @ordered_item = OrderedItem.new(current_params)

    if @ordered_item.save
      CustomerMailer.order_confirmation_email(current_customer, @ordered_item).deliver
      redirect_to root_url, notice: 'Ordered item was successfully created.'
    else
      render :new
    end
  end

  def update

    if (current_customer.try(:admin?))
      current_params = ordered_item_params
    else
      current_params = ordered_item_params_restricted_for_customer
    end
    if @ordered_item.update(current_params)

      if @ordered_item.is_dispatched && !@ordered_item.shipping_mail_sent
        CustomerMailer.shipping_email(current_customer, @ordered_item).deliver
        @ordered_item.update_attribute(:shipping_mail_sent, true)
      end

      if @ordered_item.paid && !@ordered_item.payment_mail_sent
        CustomerMailer.payment_email(current_customer, @ordered_item).deliver
        @ordered_item.update_attribute(:payment_mail_sent, true)
      end

      redirect_to @ordered_item, notice: 'Ordered item was successfully updated.'
    else
      render :edit
    end
  end

  def destroy

    unless @ordered_item.customer == current_customer
      flash[:error] = 'This order does not exist!'
      redirect_to(root_url) and return
    end

    unless current_customer.try(:admin?)
      if !@ordered_item.is_dispatched?
        @ordered_item.destroy
        redirect_to ordered_items_url, notice: 'Ordered item was successfully destroyed.'
      else
        redirect_to ordered_items_url, error: 'You can\'t delete your order if it has already been shipped!' and return
        #return
      end
    end

    @ordered_item.destroy
    redirect_to ordered_items_url, notice: 'Ordered item was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ordered_item
      @ordered_item = OrderedItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ordered_item_params
      params.require(:ordered_item).permit(:quantity, :item_id, :customer_id,
      :is_in_process, :is_dispatched, :is_delivered, :is_rejected, :paid)
      #params.require(:ordered_item).permit(:quantity, :item_id)
    end

    def ordered_item_params_restricted_for_customer
      params.require(:ordered_item).permit(:quantity, :item_id)
    end

    def check_not_admin
      unless current_customer.try(:admin?)
        flash[:notice] = 'You cannot change your order. If the item is still not shipped, you can delete your order!'
        redirect_to(ordered_items_url) and return
      end
    end

    def check_admin
      if current_customer.try(:admin?)
        flash[:notice] = 'You are not allowed to placing or deleting any orders!'
        redirect_to(items_url)
      end
    end

    def check_order_owner?(ordered_item)
      unless ordered_item.customer == current_customer
        redirect_to(ordered_items_url) and return
      end
    end
end
