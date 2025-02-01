module Api::V1
  class AuthenticationController < ApplicationController
    def login
      user = User.find_by_email(params[:email])
      if user&.valid_password?(params[:password])
        # Use Warden-JWT-Auth to generate token
        token = Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first
        render json: { token: token }
      else
        render json: { error: 'Invalid credentials' }, status: :unauthorized
      end
    end

  end
end