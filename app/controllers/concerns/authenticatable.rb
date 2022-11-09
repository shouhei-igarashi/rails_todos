module Authenticatable
    def authenticate_with_token
      raise AuthenticationError if unauthorized?
    end
  
    def current_user
      authenticate_jwt_service = AuthenticateJwtService.new(cookies[:token])
      user = authenticate_jwt_service.execute
    rescue AuthenticationError
      nil
    end
  
    def unauthorized?
      current_user.nil?
    end
  end