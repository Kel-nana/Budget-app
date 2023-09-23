Rails.application.routes.draw do
  # root to: "devise/sessions#new", as: :root_with_devise
  #setting log in as default home page 
  root 'home_pages#home'
  resources :categories do
    resources :purchases, only: [:new, :show]
  end
  resources :purchases
  # devise_scope :user do #Wrap the root path inside a devise_scope block
  devise_for :users
 #  custom video route here
 get '/videos/:video_name', to: 'videos#show', as: 'video'
end
