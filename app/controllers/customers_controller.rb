class CustomersController < ApplicationController

  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  #before_action :authenticate_customer!
  #before_action :check_admin
  #before_action :authorized, :only => [:new, :destroy]


  # GET /customers
  # GET /customers.json

  #before_filter :configure_permitted_parameters

#  protected

  # my custom fields are :name, :heard_how
  #def configure_permitted_parameters
  #  devise_parameter_sanitizer.for(:sign_up) do |u|
  #    u.permit(:forename, :surname, :date_of_birth,
  #      :email, :password, :password_confirmation)
  #  end

    #def configure_permitted_parameters
    #devise_parameter_sanitizer.for(:sign_up) << :forname, :surname, :date_of_birth
    #end

    #devise_parameter_sanitizer.for(:account_update) do |u|
    #  u.permit(:name,
    #    :email, :password, :password_confirmation, :current_password)
    #end

  #end


  def index

    @customers = Customer.all
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
  end

  # GET /customers/new
  def new
    @customer = Customer.new
    #@customer.address = Address.new
    @customer.build_address
    #@company.build_subscription
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: 'Customer was successfully created.' }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:surname, :forename, :email, :date_of_birth, :address_attributes => [:id, :street, :house_number, :postcode, :country], :addresses_attributes => [:id, :street, :house_number, :postcode, :country])
    end

    def check_admin
      unless current_customer.try(:admin?)
        # auch kein Flash, weil wozu..
        redirect_to(root_url)
      end
    end

    def authorized
        flash[:error] = 'You are not allowed creating or deliting new customers!'
        redirect_to(customers_url)
    end


end
