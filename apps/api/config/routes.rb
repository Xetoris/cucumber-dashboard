# Configure your routes here
# See: http://www.rubydoc.info/gems/hanami-router/#Usage

#get '/regressions', ''
#get '/executions', ''
get '/', to: -> (env){[200, {}, ['API']]}
get '/runs', to: 'runs#collection'
post '/runs', to: 'runs#create'
get '/runs/:id', to: 'runs#get'
