class CreateTodoHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :todo_histories do |t|
      t.string :title
      t.string :detail
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
