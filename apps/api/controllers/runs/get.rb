require 'json'
require_relative '../../../../lib/dashboard/repositories/run_repository'

module Api::Controllers::Runs
  class Get
    include Api::Action

    def call(params)
      self.body = Dashboard::Repositories::RunRepository.new.get_run(params[:id]).to_json
    end
  end
end