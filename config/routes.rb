Rails.application.routes.draw do
  get 'static_pages/home'

  get 'static_pages/index'

  get 'profiles/show'

  get 'relationships/follow_user'

  get 'relationships/unfollow_user'

  get 'profiles/index'

  get 'static_pages/home'

  get 'profiles/following'

  get 'profiles/followers'

  get ':user_name', to: 'profiles#show', as: :profile
  get ':user_name/edit', to: 'profiles#edit', as: :edit_profile
  post ':user_name/follow_user', to: 'relationships#follow_user', as: :follow_user
  post ':user_name/unfollow_user', to: 'relationships#unfollow_user', as: :unfollow_user
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :tweets
  root to: 'static_pages#home'
end
