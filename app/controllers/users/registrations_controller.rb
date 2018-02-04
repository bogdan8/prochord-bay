module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_permitted_parameters
    prepend_before_action :check_captcha, only: %i[create]

    def create
      super
    end

    protected

    def check_captcha
      return if verify_recaptcha
      self.resource = resource_class.new sign_up_params
      resource.validate
      respond_with_navigational(resource) { render :new }
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: %I[name])
      devise_parameter_sanitizer.permit(:account_update, keys: %i[name])
    end
  end
end
