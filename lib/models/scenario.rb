module CucumberDashboard
  module Models
    # Represents details about cucumber scenario.
    class Scenario
      # @return [String] Name of the feature containing the scenario.
      attr_accessor :feature_name

      # @return [String] Name of the physical file containing the scenario.
      attr_accessor :file_name

      # @return [String] Name of the Scenario.
      attr_accessor :name

      # @return [String] The relative path from /cucumber-web to the file.
      attr_accessor :relative_path

      # @return [Integer] The total number of steps in the scenario.
      attr_accessor :step_count

      # @return [Array<String>] The tags for the scenario.
      attr_reader :tags

      def initialize
        @tags = []
      end

      # @return [Hash] A JSON'able hash.
      def to_json
        { FeatureName: @feature_name,
          FileName: @file_name,
          Name: @name,
          RelativePath: @relative_path,
          StepCount: @step_count,
          Tags: @tags }
      end

      class << self
        # Returns a new instance built from a JSON string.
        #
        # @param json_string [String] The JSON string to deserialize.
        #
        # @return [Scenario]
        def from_json(json_string)
          json = MultiJson.load(json_string)
          model = new

          model.feature_name = json[:FeatureName]
          model.file_name = json[:FileName]
          model.name = json[:Name]
          model.relative_path = json[:RelativePath]
          model.step_count = json[:StepCount]
          model.tags.push(json[:Tags])

          model
        end
      end
    end
  end
end