Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  api_version(module: 'api/v1', path: { value: 'api/v1' }) do
    resource :reservations, only: %i(create update)
  end
end
