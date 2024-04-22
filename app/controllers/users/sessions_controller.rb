# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in

  # POST /resource/sign_in
  # def create
  #   super
  # end


def create
  self.resource = warden.authenticate(auth_options)
  if resource
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  else
    redirect_based_on_error
  end
end

  private

  def redirect_based_on_error
    user = resource_class.find_by(email: sign_in_params[:email])
    if user.nil?
      redirect_to new_user_registration_path, notice: "No Account Found. Please Sign Up"
    else
      redirect_to new_user_session_path, notice:"Password Incorrect"
    end
  end
end

  
  
  

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

