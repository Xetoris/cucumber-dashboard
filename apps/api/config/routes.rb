# Configure your routes here
# See: http://www.rubydoc.info/gems/hanami-router/#Usage

#get '/regressions', ''
#get '/executions', ''
get '/', to: -> (env){[200, {}, ['API']]}
get '/features', to: 'features#collection'
get '/features/:id', to: 'features#get'
get '/executions', to: 'executions#collection'
get '/executions/:id', to: 'executions#get'