class Api::V1::RegistrationsController < ApiController
  skip_before_action :require_login

  def create
    user = User.new(user_params)
    if user.save
      token = user.generate_auth_token
      render json: {
        auth_token: token,
        success: true,
        isConfirmed: false,
        user: { id: "#{user.id}" , email: "#{user.email}" } ,
        message: "Email confirmation is send successfully to #{params[:user][:email]}."
      }, status: 201
      # success_response_with_object(user,
        # "")
    else
      error_response(user, 'Failed to register user.')
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
