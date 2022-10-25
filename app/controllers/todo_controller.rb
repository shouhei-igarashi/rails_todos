class TodoController < ApplicationController
    def create
        todo = Todo.new({title: params[:title], detail: params[:detail]})
        
        if todo.save
            render json: { status: 'Success', title: params[:title], detail:params[:detail]}
        else
            render json: { status: 'Error', title: params[:title], detail:params[:detail] }    
        end
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
