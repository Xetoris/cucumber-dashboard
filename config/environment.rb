require 'bundler/setup'
require 'hanami/setup'
require 'multi_json'
#require 'hanami/model'
#require_relative '../lib/cucumber_dashboard'
require_relative '../apps/api/application'
require_relative '../apps/web/application'

Hanami.configure do
  mount Api::Application, at: '/api'
  mount Web::Application, at: '/'

  environment :development do
    # See: http://hanamirb.org/guides/projects/logging
    logger level: :debug
  end

  environment :production do
    logger level: :info, formatter: :json
  end
end
