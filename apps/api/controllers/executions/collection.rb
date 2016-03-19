require 'json'
require_relative '../../utility/validations'
require_relative '../../../../lib/dashboard/repositories/execution_repository'

module Api::Controllers::Executions
  class Collection
    include Api::Action

    params do
      param :id, format: Api::Utility::Validations.mongo_id
      param :feature_id, format: Api::Utility::Validations.mongo_id
      param :feature_name, format: Api::Utility::Validations.feature_name
      param :status, format: Api::Utility::Validations.text_only
    end

    def call(params)
      unless params.valid?
        self.body = 'Invalid parameters!'
        return
      end

      self.body = ExecutionRepository.new.get_executions_with_query(params.to_hash).to_json
    end
  end
end