require 'json'
require_relative '../../utility/validations'
require_relative '../../../../lib/dashboard/repositories/feature_repository'

module Api::Controllers::Features
  class Get
    include Api::Action

    params do
      param :id, format: Api::Utility::Validations.mongo_id
    end

    def call(params)
      self.body = FeatureRepository.new.get_feature_by_id(params[:id]).to_json
    end
  end
end