Rails.application.routes.draw do
  get 'accounts/index'
  root 'accounts#index'

  resources :accounts do
  	collection do
  		get 	:get_balance
  		get 	:show_balance
  	end
  end
  resources :transactions
end
