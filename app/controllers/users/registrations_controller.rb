class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_sign_up_params, only: [:create]
  before_filter :configure_account_update_params, only: [:update]


  def unlink_provider
    current_user.unlink_provider(params[:provider])
    redirect_to edit_user_registration_path
  end

  def respond_with(resource, *args)
    respond_to do |format|
      format.html{ super(resource)}
      format.json do
        if resource.persisted?
          render json: {url: args[0][:location]}, status: 200
        else
          render json: {errors: resource.errors.full_messages, fields_with_errors: resource.errors.keys }, status: 422
        end
      end
    end
  end


  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #  super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  #PUT /resource
  def update
    if params[:user][:email].blank?
      params[:user].delete(:email)
    else
      params[:user][:has_email] = true
    end
    super
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

 protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.for(:sign_up) << :name
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.for(:account_update) { |u|
      u.permit(:email, :password, :password_confirmation, :current_password, :name, :has_email, :avatar_attributes => :image)
    }
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  def update_resource(resource, params)
    if !resource.has_password?
      params.delete("current_password")
      resource.update_without_password(params)
    else
      resource.update_with_password(params)
    end
  end

  def after_update_path_for(resource)
    root_path
  end

  def user_url(*args)
    root_path
  end

  def admin_url(*args)
    root_path
  end

end
