class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  rescue_from ActiveRecord::DeleteRestrictionError do |exception|
    redirect_to(:back, :alert => exception.message)
  end

  protected

  # my custom fields are :name, :heard_how
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:forename, :surname, :date_of_birth,
      :email, :password, :password_confirmation,
      #address_attributes: [:street, :house_number, :postcode, :country,])
      address_attributes: [:id, :street, :house_number, :postcode, :country])
    end
  #end

     #def configure_permitted_parameters
     #devise_parameter_sanitizer.for(:sign_up) << :forname, :surname, :date_of_birth
     #end

     devise_parameter_sanitizer.for(:account_update) do |u|
       u.permit(:forename, :surname, :date_of_birth,
         :email, :password, :password_confirmation, :current_password,
         address_attributes: [:id, :street, :house_number, :postcode, :country])
     end
end
end
