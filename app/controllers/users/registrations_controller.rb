module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_permitted_parameters

    private

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up).push(:name)
      devise_parameter_sanitizer.for(:account_update).push(:name)
    end
  end
end