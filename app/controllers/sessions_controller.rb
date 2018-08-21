class SessionsController < ApplicationController
  # POST /login
  def create
    @user = User.find_by(username: params[:username].downcase)
    return invalid_login_attempt unless @user

    if @user.valid_password?(params[:password])
      sign_in :user, @user
      render json: UserSerializer.new(current_user).serialized_json
    else
      invalid_login_attempt
    end
  end

  private

    def invalid_login_attempt
      warden.custom_failure!
      render json: {error: I18n.t('sessions_controller.invalid_login_attempt')}, status: :unprocessable_entity
    end

end