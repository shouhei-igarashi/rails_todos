class SessionsController < ApplicationController 
    def create
        authenticatePasswordService = AuthenticatePasswordService.new(params[:email], params[:password])
        user = authenticatePasswordService.execute
        
        payload = {
            iss: "myapp",
            sub: user.id,
            exp: (DateTime.current + 14.days).to_i
        }

        rsa_private = OpenSSL::PKey::RSA.new(File.read(Rails.root.join('app/auth/service.key')))

        token = JWT.encode(payload, rsa_private, "RS256")
        cookies[:token] = token
        
        render status: :created
    end
end