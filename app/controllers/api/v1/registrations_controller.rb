class Api::V1::RegistrationsController < ApiController
  skip_before_action :require_login

  def create
    user = User.new(user_params)
    if user.save
      success_response_with_object(user,
        "Email confirmation is send successfully to #{params[:user][:email]}.")
    else
      error_response(user, 'Failed to register user.')
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
