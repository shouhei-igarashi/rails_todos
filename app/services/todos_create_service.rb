class TodosCreateService
    def initialize(title, detail, user_id)
        @title = title
        @detail = detail
        @user_id = user_id
    end
    
    attr_reader :title, :detail, :user_id

    def create()
        todo = Todo.new(title: title, detail: detail, user_id: user_id)
        todo_history = TodoHistory.new(title: title, detail: detail, user_id: user_id)
        
        is_success = todo.save
        todo_history.save
        
        return is_success
    end

    def update(todo_id)
        todo = Todo.find(todo_id)
        todo.destroy
        
        todo = Todo.new(title: title, detail: detail, user_id: user_id)
        todo_history = TodoHistory.new(title: title, detail: detail, user_id: user_id)
        status = 500
        
        if todo.save
            status = :created
        end

        todo_history.save
        return status
    end
end