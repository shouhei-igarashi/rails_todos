Rails.application.routes.draw do
  post "signin", to: "sessions#create"
  get "user", to:"sessions#show"
  put "todo/create", to:"todos#create"
end
