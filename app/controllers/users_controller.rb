class UsersController < ApplicationController
  # POST /users (create a new user)
  def create
    @user = User.new(user_params)

    if @user.save
      render json: SessionSerializer.new(@user).serialized_json
    else
      render json: { error: I18n.t('user_create_error') }, status: :unprocessable_entity
    end
  end

  private

    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
end
