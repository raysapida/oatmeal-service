Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope '/api' do
    get '/tweets', to: 'twitter#index'
    get '/search', to: 'twitter#search'
  end
end
