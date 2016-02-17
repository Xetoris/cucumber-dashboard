require_relative '../../../../lib/dashboard/repositories/feature_repository'
require 'json'

module Api::Controllers::Features
  class Get
    include Api::Action

    def call(params)
      self.body = FeatureRepository.new.get_feature_by_id(params[:id]).to_json
    end
  end
end