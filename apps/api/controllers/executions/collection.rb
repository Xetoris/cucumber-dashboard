require_relative '../../../../lib/dashboard/repositories/execution_repository'
require 'json'

module Api::Controllers::Executions
  class Collection
    include Api::Action

    def call(params)
      self.body = ExecutionRepository.new.get_executions.to_json
    end
  end
end