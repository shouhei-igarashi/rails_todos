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

    def show
        token = cookies[:token]
        rsa_private = OpenSSL::PKey::RSA.new(File.read(Rails.root.join('app/auth/service.key')))

        begin
            decoded_token = JWT.decode(token, rsa_private, true, { algorithm: 'RS256' })
        rescue JWT::DecodeError, JWT::ExpiredSignature, JWT::VerificationError
            return render json: { message: 'unauthorized' }, status: :unauthorized
        end

        user_id = decoded_token.first["sub"]

        # ユーザーを検索
        user = User.find(user_id)

        # userが取得できた場合はユーザー情報を返す、取得できない場合は認証エラー
        if user.nil?
            raise AuthenticationError
        else
            render json: {
            user: {
                id: user.id,
                emai: user.email
            }
            }, status: :ok
        end
    end
end