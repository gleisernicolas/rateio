Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  resources :expenses, only: [:new, :create, :show, :index, :update, :edit]

  resources :user_expenses, only: [:update, :show] do
    post 'paid', on: :member
    member do
      post 'paid'
      post 'voucher'
    end
  end

  get '/convites/:token', to: 'expenses#invite', as: 'expense_invite'
  post '/convites/:token/aceitar', to: 'expenses#accept_invite',
                                   as: 'expense_invite_accepted'
end
