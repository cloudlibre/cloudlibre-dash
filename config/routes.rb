Rails.application.routes.draw do
  # scope format: false do
  #   defaults format: 'html' do
  resources :zones, param: :name, constraints: { name: /[^\/]+/ }, format: false, defaults: { format: 'html' } do
    resources :dns_records
  end
  #   end
  # end
  get 'home/index'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  unauthenticated do
    root to: 'home#index', as: 'unauthenticated_root'
  end
  authenticated  do
      root to: 'zones#index'
   end
end
