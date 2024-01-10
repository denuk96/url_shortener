Rails.application.routes.draw do
  resources :links, only: %i[create show update destroy], param: :slug
  get '/:slug', to: "links#index"

  namespace :admin do
    resources :links, only: %i[index destroy], param: :slug do
      delete 'destroy_old', on: :collection
    end
  end
end
