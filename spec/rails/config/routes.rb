Rails.application.routes.draw do
  resources :topics, only: %i[index show create update destroy] do
    resources :books, only: %i[index]
  end

  resources :books, only: [] do
    member do
      patch :promote
    end
  end
end
