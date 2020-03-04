class Users::AdminSessionsController < Devise::SessionsController
  before_filter :configure_sign_in_params, only: [:create]

  # # GET /admin/sign_in
  def new
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    yield resource if block_given?
  end

  # # POST /admin/sign_in
  def create
    #self.resource = warden.authenticate!(auth_options)
    self.resource = User.admin_user_flag.find_by!(email: sign_in_params[:email])
    if self.resource.nil? || !self.resource.valid_password?(sign_in_params[:password])
      flash[:alert] = auth_fail_message
      redirect_to admin_session_path
      return
    end

    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

  protected

  # You can put the params you want to permit in the empty array.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
  end

  def sign_in_params
    s_params = devise_parameter_sanitizer.sanitize(:sign_in)
    s_params[:admin_user_flag] = true

    s_params
  end

  def auth_fail_message
    # t("devise.failure.not_found_in_database",
    #   authentication_keys: resource_class.authentication_keys.map { |e|
    #     t("activerecord.attributes.user.#{e}", raise: true) rescue e.to_s.titleize
    #   }.join(", ")
    # )
    t('devise.failure.not_found_in_database_admin', authentication_keys: 'Email')
  end
end
