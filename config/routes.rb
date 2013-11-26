Bloccit::Application.routes.draw do

  devise_for :users

  resources :topics do
    resources :posts, except: [:index] do
      resources :comments, only: [:create, :destroy]
      get '/up-vote', to: 'votes#up_vote', as: :up_vote
      get '/down-vote', to: 'votes#down_vote', as: :down_vote
    end
  end

  match "about" => 'welcome#about', via: :get

  root :to => 'welcome#index'
end