require 'multi_json'
require_relative '../../../../lib/dashboard/repositories/run_repository'

module Api::Controllers::Runs
  class Get
    include Api::Action

    def call(params)
      self.body = MultiJson.dump(Dashboard::Repositories::RunRepository.new.get_run(params[:id]))
    end
  end
end