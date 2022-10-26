class TodoController < ApplicationController
    def create
        todo = Todo.new({title: params[:title], detail: params[:detail]})
        status = 'Error'
        
        if todo.save
            status = 'Success'
        end

        render json: { status: status, title: params[:title], detail:params[:detail]}
    end

    def show
        todos = Todo.all
        render json: { todos: todos }
    end

    def delete
        todo = Todo.find(params[:id])
        todo.destroy
        
        render json: { todos: todo }
    end 
end
