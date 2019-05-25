Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :venues, only: [] do
    resources :floors, only: [] do
      resources :seats, only: [:index, :show]
    end
  end

  resources :seats, only: [] do
    resources :selections, only: [:create]
  end

  root to: redirect("/venues/benedum_center/floors/orchestra/seats")
end
