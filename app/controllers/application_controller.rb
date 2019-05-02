class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  def after_sign_in_path_for(resource)
    # verificar a role do usuário para redirecionar para a página correta.
    if current_user.role == "suspended"
      sign_out current_user
      page_url(:about, :alert => "Seu usuário está suspenso. Por favor entre em contato com o administrador do sistema.")
    else
      protocol_protocol_path
    end
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

  def admin_only
    unless current_user.admin?
      redirect_to root_path, :alert => "Acesso Negado! ##{request.remote_ip} IP gravado!"
    end
  end


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role, :mobile, :cpf, :crm, :speciality, :plan])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :role, :mobile, :cpf, :crm, :speciality, :plan])
  end

  def verify_suspension
    if !current_user.blank? && current_user.role.to_sym == :suspended
      redirect_to users_path, :alert => "Seu usuário está suspenso. Por favor entre em contato com o administrador do sistema."
      false
    else
      :authenticate_user!
    end
  end

end
