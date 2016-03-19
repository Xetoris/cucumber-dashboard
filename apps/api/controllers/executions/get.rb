require 'json'
require_relative '../../utility/validations'
require_relative '../../../../lib/dashboard/repositories/execution_repository'

module Api::Controllers::Executions
  class Get
    include Api::Action

    params do
      param :id, format: Api::Utility::Validations.mongo_id
    end

    def call(params)
      unless params.valid?
        self.body = 'Invalid parameters!'
        return
      end

      self.body = ExecutionRepository.new.get_execution_by_id(params[:id]).to_json
    end
  end
end