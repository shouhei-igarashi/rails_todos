Rails.application.routes.draw do
  post "todo/create" => "todo#create"
  get "todo/show" => "todo#show"
  delete "todo/delete/:id" => "todo#delete"
end
