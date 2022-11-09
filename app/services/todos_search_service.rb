class TodosSearchService
    def initialize(user_id)
        @user_id = user_id
    end
    
    attr_reader :user_id

    def find_by_id(todo_id)
        todos = Todo.find_by(id:todo_id, user_id: user_id)

        return todos
    end

    def find_by_user_id()
        todos = Todo.where(user_id: user_id)

        return todos
    end

    def find_by_title(title)
        todos = Todo.where(title: title, user_id: user_id)
        
        return todos
    end

    def find_by_detail(detail)
        todos = Todo.where(detail: detail, user_id: user_id)
        
        return todos
    end

    def find_by_title_and_detail(title, detail)
        todos = Todo.where(title:title, detail: detail, user_id: user_id)
        
        return todos
    end
end