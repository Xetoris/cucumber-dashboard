module CucumberDashboard
  module Models
    # Represents a regression run.
    class Run
      # @return [Integer] Time executed in seconds.
      attr_accessor :duration

      # @return [DateTime] The time that the run finished.
      attr_accessor :end_time

      # @return [RunError, Null] The error information.
      attr_accessor :error

      # @return [String] Id of the scenario run.
      attr_accessor :scenario_id

      # @return [DateTime] The time that the run started.
      attr_accessor :start_time

      # @return [Integer] Id of the status.
      attr_accessor :status

      # @return [String] Name of the status.
      attr_accessor :status_name

      # @return [Hash] A JSON'able hash representation of the entity.
      def to_json
        json = { Duration: @duration,
                 EndTime: @end_time.strftime(),
                 ScenarioId: @scenario_id,
                 StartTime: @start_time.strftime(),
                 Status: @status,
                 StatusName: @status_name }

        unless @error.nil?
          json[:Error] = @error.to_json
        end

        json
      end

      class << self
        # Returns a model instance from a JSON string.
        #
        # @param json_string [String] The JSON string to deserialize.
        #
        # @return [Run]
        def from_json(json_string)
          json = MultiJson.load(json_string)
          model = new

          model.duration = json[:Duration]
          model.end_time = json[:EndTime]
          model.start_time = json[:StartTime]
          model.status = json[:Status]

          if json.has_key?(:Error)
            model.error = RunError.from_json_hash(json[:Error])
          end

          model
        end
      end
    end

    # Represents the details of a run's failure.
    class RunError
      # @return [String] Full path to the file where the error occurred.
      attr_accessor :file_name

      # @return [String] The error class for the error.
      attr_accessor :error_type

      # @return [String] Line number of the error'ing method.
      attr_accessor :line_number

      # @return [String] The message from the error details.
      attr_accessor :message

      # @return [Array<String>] The backtrace to the error.
      attr_reader :stack_trace

      def initialize
        @stack_trace = []
      end

      # @return [Hash] A JSON'able hash representation of the entity.
      def to_json
        { FileName: @file_name,
          ErrorType: @error_type,
          LineNumber: @line_number,
          Message: @message,
          StackTrace: @stack_trace }
      end

      class << self
        # Returns a model instance from a JSON hash.
        #
        # @param hash [Hash] The JSON hash.
        #
        # @return [RunError]
        def from_json_hash(hash)
          model = new

          model.file_name = hash[:FileName]
          model.error_type = hash[:ErrorType]
          model.line_number = hash[:LineNumber]
          model.message = hash[:Message]
          model.stack_trace.push(hash[:StackTrace])

          model
        end
      end
    end
  end
end