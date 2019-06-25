class Api::V1::SessionsController < ApiController
    skip_before_action :require_login, only: :create
  
    def create
      user = User.find_by(email: params[:user][:email])
      if user.present?
        if user.valid_password?(params[:user][:password])
          if user.confirmed?
            token = user.generate_auth_token
            render json: {
              success: true,
              user: {
                id: user.id,
                email: user.email,
              },
              auth_token: token,
              message: 'Logged in successfully.'
            }, status: 201
          else
            error_response_without_obj('Please confirm your account.')
          end
        else
          error_response_without_obj('Password is invalid.')
        end
      else
        error_response_without_obj('This email does not exist.')
      end
    end
  
    def destroy
      auth_token = AuthToken.find_by(auth_token: params[:auth_token])
      if auth_token.present?
        auth_token.destroy
        success_response('Logged out successfully.')
      else
        unauthorize_http_response('Failed to Logout.')
      end
    end
  end
  