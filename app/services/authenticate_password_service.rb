class AuthenticatePasswordService
    def initialize(email, password)
        @email = email
        @password = password
    end

    attr_reader :email, :password

    def execute
        user = User.find_by(email: email)&.authenticate(password)

        if user.nil?
            raise AuthenticationError
        end

        return user
    end
end