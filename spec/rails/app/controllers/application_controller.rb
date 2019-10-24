class ApplicationController < ActionController::API
  rescue_from Fictium::RecordNotFound do
    render status: :not_found
  end
end
