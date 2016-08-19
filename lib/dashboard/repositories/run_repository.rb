require 'mongo'

module Dashboard
  module Repositories
    class RunRepository

      def initialize
        @client = Mongo::Client.new(ENV['MONGO_CONNECTION_STRING'])
        @repository_name = :runs
      end

      def add_run(run)
        raise ('Model is of the appropriate type. See Dashboard::Entities::Run.') unless run.is_a?(Dashboard::Entities::Run)

        collection = @client[@repository_name]

        result = collection.insert_one(translate_for_mongo(run))

        run.id = result.inserted_id.to_s

        result.inserted_id.to_s
      end

      def get_run(run_id)
        raise ('Run Id must be a non-empty/nil String.') if run_id.nil? || run_id.empty? || !run_id.is_a?(String)

        results = @client[@repository_name].find(:_id => BSON::ObjectId(run_id))

        nil if results.count == 0

        translate_from_mongo(results.first, Dashboard::Entities::Run)
      end

      def get_runs_by_name(name)
        raise ('Name must be a non-empty/nil String.') if name.nil? || name.empty? || !name.is_a?(String)

        collection = @client[@repository_name].find(:nm => name)

        results = []

        collection.each do |document|
          results.push(translate_from_mongo(document, Dashboard::Entities::Run))
        end

        results
      end

      def get_runs_by_feature_name(name)
        raise ('Name must be a non-empty/nil String.') if name.nil? || name.empty? || !name.is_a?(String)

        collection = @client[@repository_name].find(:ftr => name)

        results = []

        collection.each do |document|
          results.push(translate_from_mongo(document, Dashboard::Entities::Run))
        end

        results
      end

      private

      def translate_for_mongo(model)
        raise('Model cannot be nil.') if model.nil?

        case model
          when Dashboard::Entities::Run
            model = run_to_mongo(model)
          else
            raise('No translation for this model.')
        end

        model
      end

      def translate_from_mongo(data, type)
        raise('Requested type cannot be nil.') if type.nil?

        case
          when type == Dashboard::Entities::Run
            model = run_from_mongo(data)
          else
            raise('Requested type not found.')
        end

        model
      end

      def run_from_mongo(data)
        model = Dashboard::Entities::Run.new

        model.id = data[:_id].to_s
        model.name = data[:nm]
        model.feature = data[:ftr]
        model.status = data[:sts]

        model.tags = data[:tgs]
        model.steps = []

        data[:stps].each do |step|
          model.steps.push(step_from_mongo(step))
        end

        model
      end

      def step_from_mongo(data)
        model = Dashboard::Entities::Step.new

        model.name = data[:nm]
        model.status = data[:sts]
        model.location = data[:lctn]

        if data.has_key?(:expt)
          model.exception = {
              :message => data[:expt][:msg],
              :backtrace => data[:expt][:btrc]
          }
        end

        model
      end

      def run_to_mongo(run)
        model = {
                  :_id => run.id,
                  :nm => run.name,
                  :ftr => run.feature,
                  :sts => run.status
                }

        model[:tgs] = run.tags || []

        model[:stps] = []

        run.steps.each do |step|
          model[:stps].push(step_to_mongo(step))
        end

        model
      end

      def step_to_mongo(step)
        model = {
            :nm => step.name,
            :lctn => step.location,
            :sts => step.status,
        }

        if step.exception != nil
          model[:expt] = {
              :msg => step[:message],
              :btrc => step[:backtrace] || []
          }
        end

        model
      end
    end
  end
end