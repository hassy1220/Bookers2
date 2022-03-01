class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:about,:top]
  before_action :configure_permitted_parameters, if: :devise_controller?
  

  def after_sign_in_path_for(resources)
    user_path(@user.id)
  end
  def after_sign_out_path_for(resources)
    root_path
  end

  private

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up,keys:[:email])
    end
end


