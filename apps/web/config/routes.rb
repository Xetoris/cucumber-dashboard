# Configure your routes here
# See: http://www.rubydoc.info/gems/hanami-router/#Usage

get '/', to: 'dashboard#index', as: :dashboard
get '/features', to: 'features#index', as: :features
get '/features/:id', to: 'features#feature_detail'