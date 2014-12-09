JoeSorceConstruction::Application.routes.draw do
  root 'welcome#index', as: 'root'

  devise_for :admin

  get '/welcome/index' => 'welcome#index', as: 'index'
  get '/admin/settings' => 'admin#settings'
  get '/album_images/:album_id' => 'admin#album_images'
  get '/albums' => 'admin#albums'

  post '/payment' => 'payment#express_payment', as: 'payment'
  post '/bid_upload' => 'welcome#bid_upload'
  post '/update_story' => 'admin#update_story'
  post '/contact_us' => 'welcome#contact_us'
  post '/credit_card_payment' => 'payment#credit_card_payment'
end
