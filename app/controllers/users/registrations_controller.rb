class Users::RegistrationsController < Devise::RegistrationsController
    before_action :configure_account_update_params, only: [:create, :update]

    protected

    def configure_account_update_params
        devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email, :password,:password_confirmation])
        devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :email, :password,:password_confirmation])
    end

    # If you have extra params to permit, append them to the sanitizer.
    # def configure_sign_in_params
    #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
    # end
end
