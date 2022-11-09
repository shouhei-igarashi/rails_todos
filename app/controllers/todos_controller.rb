class TodosController < ApplicationController
    include Authenticatable

    before_action :authenticate_with_token
    
    def create
        user = get_token_user

        todos_create_service = TodosCreateService.new(params[:title], params[:detail], user.id)
        is_success = todos_create_service.create
        
        render json: { status: is_success ? 200 : 500, title: params[:title], detail:params[:detail]}
    end

    def show
        user = get_token_user

        todo_search_service = TodosSearchService.new(user.id)
        render json: { status:200, todos: todo_search_service.find_by_user_id}
    end

    private def get_token_user
        authenticate_jwt_service = AuthenticateJwtService.new(cookies[:token])
        user = authenticate_jwt_service.execute

        return user
    end
end
