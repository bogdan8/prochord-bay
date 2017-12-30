module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    before_action :social_user, only: %i[twitter facebook]

    def twitter; end

    def facebook; end

    private

    def social_user
      user = User.from_omniauth(env['omniauth.auth'])
      if user.persisted?
        sign_in_and_redirect user, flash: { success: t('controllers.user.success_sign_in') }
      else
        redirect_to new_user_registration_url
        session['devise.user_attributes'] = user.attributes
      end
    end
  end
end
