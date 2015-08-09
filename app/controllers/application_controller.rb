class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  # my custom fields are :name, :heard_how
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:forename, :surname, :date_of_birth, 
      :email, :password, :password_confirmation)
      end
    end

     #def configure_permitted_parameters
     #devise_parameter_sanitizer.for(:sign_up) << :forname, :surname, :date_of_birth
     #end

     #devise_parameter_sanitizer.for(:account_update) do |u|
     #  u.permit(:name,
     #    :email, :password, :password_confirmation, :current_password)
     #end

end
