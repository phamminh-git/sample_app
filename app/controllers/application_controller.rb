class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :set_locale

  private
  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    check = I18n.available_locales.include? locale
    I18n.locale = check ? locale : I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def show_errors_messages messages
    messages.each do |attribute, message|
      flash[:danger] = [attribute.to_s.capitalize, message[0]].join(": ")
    end
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t "users.index.login_message"
    redirect_to login_url
  end
end
