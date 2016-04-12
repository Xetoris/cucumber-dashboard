require_relative '../../utility/api_helper'

module Web::Controllers::Features
  class Index
    include Web::Action
    #include Web::Utility::ApiHelper

    #expose :features

    def call(params)
      #@features = JSON.parse(api_get('features'))
    end
  end
end