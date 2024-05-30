Rails.application.routes.draw do
  get 'user_sessions/new'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :users do
    collection do
      get 'students/new', to: 'users#new_student', as: 'new_student'
      post 'students/create', to: 'users#create_student', as: 'create_student'
      get 'students/:id', to: 'users#show_student', as: 'show_student'
      delete 'students/:id', to: 'users#destroy_student', as: 'destroy_student'
    end
  end

  get "user/student" => "users#new"
  get "user/all_students", to: "users#all_students"

  resources :user_sessions, only: [:new, :create, :destroy]


  # Defines the root path route ("/")
  # root "posts#index"
  root "users#index"
end
