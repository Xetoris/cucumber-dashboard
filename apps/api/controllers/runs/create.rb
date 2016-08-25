require 'multi_json'
require_relative '../../../../lib/dashboard/repositories/run_repository'
require_relative '../../../../lib/dashboard/entities/run'
require_relative '../../validators/run_validator'

module Api::Controllers::Runs
  class Create
    include Api::Action

    params RunValidator

    def call(params)
      if params.valid?
        run = Dashboard::Entities::Run.new

        run.name = params[:name]
        run.feature = params[:feature]
        run.status = params[:status]
        run.create_date = Time.now.utc

        unless params[:tags].nil?
          params[:tags].each do |tag|
            run.tags.push(tag)
          end
        end

        unless params[:steps].nil?
          params[:steps].each do |step_request|
            step = Dashboard::Entities::Step.new

            step.name = step_request[:name]
            step.location = step_request[:location]
            step.status = step_request[:status]

            if step_request.has_key?(:exception)
              step.exception = {
                  :message => step_request[:exception][:message],
                  :backtrace => step_request[:exception][:backtrace]
              }
            end
          end
        end

        id = Dashboard::Repositories::RunRepository.new.add_run(run)

        self.body = 'Run was successfully created'
        self.status = 201
        self.headers.merge!({'X-CukeDash-RunId' => id})

      else
        status 400, MultiJson.dump(params.errors)
      end
    end
  end
end