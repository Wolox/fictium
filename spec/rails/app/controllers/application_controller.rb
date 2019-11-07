class ApplicationController < ActionController::API
  before_action :authenticate_user!

  rescue_from ActionController::ParameterMissing do |error|
    render json: { message: error }, status: :unprocessable_entity
  end

  rescue_from Fictium::RecordNotFound do
    render status: :not_found
  end

  rescue_from Fictium::Unauthorized do
    render status: :unauthorized
  end

  private

  def authenticate_user!
    raise Fictium::Unauthorized unless valid_jwt_token?
  end

  def valid_jwt_token?
    request.headers['Authorization'] == 'Bearer <token>'
  end
end
