class BubuMailer < Devise::Mailer

  layout 'mailer'

  protected

  def subject_for(key)
    devise_default = I18n.t(:"#{devise_mapping.name}_subject", scope: [:devise, :mailer, key], default: [:subject, key.to_s.humanize])
    "[BubuDoctor] #{devise_default}"
  end

end
