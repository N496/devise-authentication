class Api::V1::ConfirmationsController < ApiController
  skip_before_action :require_login

  def create
    if params[:confirmation_token].present?
      user = User.find_by(confirmation_token: params[:confirmation_token])
      if user.present?
        user.confirmed_at = Time.zone.now
        user.confirmation_token = nil
        user.confirmation_sent_at = nil
        user.save(validate: false)
        token = user.generate_auth_token
        render json: {
          auth_token: token,
          success: true,
          isConfirmed: true,
          user: { id: "#{user.id}" , email: "#{user.email}" } ,
          message: "Your account is confirmed successfully."
        }, status: 201
      else
        unauthorize_http_response('Confirmation Token is invalid.')
      end
    else
      error_response_without_obj('Confirmation Token is missing.')
    end
  end

  def resend
    user = User.find_by(email: params[:email])
    if user.present?
      user.send_confirmation_instructions
      success_response_with_object(user,
        "Email confirmation is send successfully to #{params[:email]}.")
    else
      error_response_without_obj('Email is invalid.')
    end
  end
end
