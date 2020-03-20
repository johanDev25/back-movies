Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :movies, only: [:index, :create, :destroy]
      get '/movies/:name', to: "movies#search"
      get '/movies/dates', to: "movies#searchByDate"
    end
  end
end
