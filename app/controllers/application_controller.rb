class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  def after_sign_in_path_for(resource)
    # verificar a role do usuário para redirecionar para a página correta.
    thankyou_path
  end

  def set_locale
    if params[:locale]
      I18n.locale = params[:locale]
      session[:locale] = params[:locale]
    else
      if session[:locale]
        I18n.locale = session[:locale]
      else
        I18n.locale = current_locale
      end
    end
  end
  helper_method :set_locale

  def current_locale
    # recupera o locale de acordo com as configurações da máquina do usuário
    # request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first

    # define local :pt-BR para o caso da Casetec
    'pt-BR'

  end
  helper_method :current_locale

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role, :mobile, :cpf, :crm, :speciality, :plan])
    #devise_parameter_sanitizer.permit(:sign_in, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :role, :mobile, :cpf, :crm, :speciality, :plan])
  end

end
