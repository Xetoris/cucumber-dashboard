require 'json'
require_relative '../../utility/validations'
require_relative '../../../../lib/dashboard/repositories/feature_repository'

module Api::Controllers::Features
  class Collection
    include Api::Action

    params do
      param :name, format: Api::Utility::Validations.feature_name
      param :tags, format: Api::Utility::Validations.tag_csv
    end

    def call(params)
      unless params.valid?
        self.body = 'Invalid Parameters'
        return
      end

      self.body = FeatureRepository.new.get_features_with_query(params.to_hash).to_json
    end
  end
end