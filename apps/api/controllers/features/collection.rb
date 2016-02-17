require_relative '../../../../lib/dashboard/repositories/feature_repository'
require 'json'

module Api::Controllers::Features
  class Collection
    include Api::Action

    def call(params)
      self.body = FeatureRepository.new.get_features.to_json
    end
  end
end