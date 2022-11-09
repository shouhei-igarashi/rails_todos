Rails.application.routes.draw do
  post "signin", to: "sessions#create"
  get "user", to:"sessions#show"
  put "todo/create", to:"todos#create"
  get "todo/all", to:"todos#show"
end
