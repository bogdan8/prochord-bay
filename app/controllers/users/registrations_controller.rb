  module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_permitted_parameters
    prepend_before_action :check_captcha, only: [:create, :update]

    private

    def check_captcha
      unless verify_recaptcha
        self.resource = resource_class.new sign_up_params
        respond_with_navigational(resource) { render :new }
      end
    end
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    end
  end
end
