require_relative '../../../lib/dashboard/repositories/feature_repository'
require 'json'

module Web::Controller::FeatureController
  class Collection
    include Web::Action

    def call(params)
      self.body = JSON.dump FeatureRepository.new.get_features
      self.status = 200
    end
  end

  class Get
    include Web::Action

    def call(params)
    end
  end
end