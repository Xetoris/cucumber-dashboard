require 'multi_json'
require_relative '../../../../lib/dashboard/repositories/run_repository'

module Api::Controllers::Runs
  class Collection
    include Api::Action

    params do
      optional(:feature).filled(:str?, format?: /^[a-zA-Z0-9\s\/_-]*$/)
      optional(:name).filled(:str?, format?: /^[a-zA-Z0-9\s\/_-]*$/)
      optional(:regression_tag).filled(:str?)
      optional(:sort_direction).filled(:str?, format?:/^(desc|asc)$/)
      optional(:start_number).filled(:int?)
      optional(:count).filled(:int?)
    end

    def call(params)
      if params.valid?
        self.body = MultiJson.dump(Dashboard::Repositories::RunRepository.new.get_runs(sort_options: {
            :count => params[:count],
            :direction => params[:sort_direction],
            :start_number => params[:start_number]}, filter_options: {
            :ftr => params[:feature],
            :nm => params[:name],
            :rtg => params[:regression_tag]
        }))
      else
        status 400, params.errors
      end
    end
  end
end