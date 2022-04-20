class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :homes_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end

  def homes_controller?
    is_a?(::HomesController)
  end
end
