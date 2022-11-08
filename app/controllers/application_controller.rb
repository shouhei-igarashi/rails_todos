class ApplicationController < ActionController::API
    include ActionController::Cookies
    
    rescue_from AuthenticationError, with: :render_unauthorized_error

    def render_unauthorized_error
        render json: { message: 'unauthorized' }, status: :unauthorized
    end
end
