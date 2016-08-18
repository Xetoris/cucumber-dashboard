require_relative 'base_entity'

module Dashboard
  module Entities

    # Represents a single Cucumber Scenario run.
    class Run < BaseEntity
      attr_accessor :name, :feature, :status
      attr_reader :id, :tags, :steps

      # Initializes a new instance of the Run class.
      #
      # @param vals [Hash] the starting values of a Run.
      # Valid Properties:
      #  :id [String] - The generated mongo instance id
      #  :name [String] - Name of the scenario
      #  :feature [String] - Name of the feature file
      #  :status [String] - The Cucumber status of the Scenario
      #  :tags [Array] - Array of strings representing the tags for the Scenario.
      #  :steps [Array] - Object array of steps completed during the scenario.
      #
      # @return [Run]
      def initialize(vals = {})

        super(vals.has_key?(:id) ? vals[:id] : nil)

        if vals.has_key?(:name)
          @name = vals[:name]
        end

        if vals.has_key?(:feature)
          @feature = vals[:feature]
        end

        if vals.has_key?(:status)
          @status = vals[:status]
        end

        @tags = []

        if vals.has_key?(:tags)
          if !vals[:tags].nil? && vals[:tags].is_a?(Array)
            vals[:tags].each do |tag|
              @tags.push(tag) unless tag.empty?
            end
          end
        end

        @steps = []

        if vals.has_key?(:steps)
          if !vals[:steps].nil? && vals[:steps].is_a?(Array)
            vals[:steps].each do |step|
              steps.push(Step.new(step))
            end
          end
        end
      end

      # ToDo: Move this to the repository ?
      # Translates the current instance to a Hash for mongo storage
      # @return [Hash]
      def to_mongo_model
        model = {
            :_id => @id,
            :nm => @name,
            :ftr => @feature,
            :sts => @status,
            :tgs => @tags,
            :stps => []
        }


        unless @steps.empty?
          @steps.each do |step|
            model[:stps].push(step.to_mongo_model)
          end
        end

        model
      end

      # ToDo: Move this to the repository ?
      # Builds an instance of Run based off the hash from Mongo
      #
      # @param mongo_data [Hash] the hash returned from mongo lookup
      #
      # @return [Run]
      def self.from_mongo_model(mongo_data)
        steps = []

        if mongo_data.has_key?('stps')
          mongo_data['stps'].each do |step|
            steps.push(Step.from_mongo_model(step))
          end
        end

        Run.new({
            :id => mongo_data['_id'],
            :name => mongo_data['nm'],
            :feature => mongo_data['ftr'],
            :status => mongo_data['sts'],
            :tags => mongo_data['tgs'],
            :steps => steps
                        })
      end
    end

    # Represents a Cucumber Step
    class Step
      attr_accessor :name, :location, :status, :exception

      # Initializes a new instance of Step class.
      #
      # @param vals [Hash] a Hash of initial values for this Step.
      # Valid Values:
      #  :name [String] - The name of the step.
      #  :location [String] - The path to the file containing the step.
      #  :status [String] - The Cucumber status of the Step.
      #  :exception [Hash] - Optional ; The Hash containing the :message [String] and :backtrace [Array] for the exception.
      def initialize(vals = {})
        if vals.has_key?(:name)
          @name = vals[:name]
        end

        if vals.has_key?(:location)
          @location = vals[:location]
        end

        if vals.has_key?(:status)
          @status = vals[:status]
        end

        if vals.has_key?(:exception)
          @exception = vals[:exception]
        end
      end

      # ToDo: Move this to repository.
      # Translates the object to a Hash for storing in mongo.
      #
      # @return [Hash]
      def to_mongo_model
        {
            :nm => @name,
            :lctn => @location,
            :sts => @status,
            :exc => {
                :msg => @exception[:message],
                :bktr => @exception[:backtrace]
            }
        }
      end

      # ToDo: Move this to the repository ?
      # Builds an instance of Step based off the hash from Mongo
      #
      # @param mongo_data [Hash] the hash returned from mongo lookup
      #
      # @return [Run]
      def self.from_mongo_model(mongo_data)
        vals = {
            :name => mongo_data['name'],
            :location => mongo_data['location'],
            :status => mongo_data['status']
        }

        if mongo_data.has_key?('exc')
          vals[:exception] = {
              :message => mongo_data['exc']['msg'],
              :backtrace => mongo_data['exc']['bktr']
          }
        end

        Step.new(vals)
      end
    end
  end
end