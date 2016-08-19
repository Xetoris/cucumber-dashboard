require 'json'
require 'multi_json'
require_relative '../../../../lib/dashboard/repositories/run_repository'

module Api::Controllers::Runs
  class Collection
    include Api::Action

    def call(params)
      self.body = MultiJson.dump(Dashboard::Repositories::RunRepository.new.get_runs)
    end
  end
end