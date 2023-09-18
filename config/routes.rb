Rails.application.routes.draw do
  # root to: "devise/sessions#new", as: :root_with_devise
  devise_for :users
#setting log in as default home page 
  devise_scope :user do #Wrap the root path inside a devise_scope block
    root to: "devise/sessions#new", as: :root_with_devise
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
end
