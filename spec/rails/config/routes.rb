Rails.application.routes.draw do
  resources :topics, only: %i[index show] do
    resources :books, only: %i[index]
  end
end
