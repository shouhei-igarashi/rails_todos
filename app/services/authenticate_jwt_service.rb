class AuthenticateJwtService
    def initialize(token)
        @token = token
    end
    
    attr_reader :token

    def execute()
        rsa_private = OpenSSL::PKey::RSA.new(File.read(Rails.root.join('app/auth/service.key')))
        
        begin
            decoded_token = JWT.decode(token, rsa_private, true, { algorithm: 'RS256' })
        rescue JWT::DecodeError, JWT::ExpiredSignature, JWT::VerificationError
            raise AuthenticationError
        end
        
        user_id = decoded_token.first["sub"]
        user = User.find(user_id)
        if user.nil?
            raise AuthenticationError 
        end

        return user
    end
end