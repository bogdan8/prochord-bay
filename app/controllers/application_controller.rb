class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  add_flash_types :success, :danger, :error

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html { redirect_to main_app.root_url, flash: { error: exception.message } }
      format.js { redirect_to main_app.root_url, flash: { error: exception.message } }
    end
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(*)
    { locale: I18n.locale }
  end
end
