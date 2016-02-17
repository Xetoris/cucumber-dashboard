require_relative '../../../../lib/dashboard/repositories/execution_repository'
require 'json'

module Api::Controllers::Executions
  class Get
    include Api::Action

    def call(params)
      self.body = ExecutionRepository.new.get_execution_by_id(params[:id]).to_json
    end
  end
end