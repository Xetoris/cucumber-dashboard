module CucumberDashboard
  module Models
    # Represents a regression run.
    class Run
      # @return [RunBuildInfo] Information about the test's initiating build.
      attr_accessor :build_info

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
      def as_json
        json = { Duration: @duration,
                 EndTime: @end_time.to_s,
                 ScenarioId: @scenario_id,
                 StartTime: @start_time.to_s,
                 Status: @status,
                 StatusName: @status_name }

        unless @error.nil?
          json[:Error] = @error.as_json
        end

        unless @build_info.nil?
          json[:BuildInfo] = @build_info.as_json
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
          model.scenario_id = json['ScenarioId']
          model.status = json['Status']

          et = json['EndTime']
          model.end_time = DateTime.parse(et) unless et.nil?

          st = json['StartTime']
          model.start_time = DateTime.parse(st) unless st.nil?


          if json.has_key?('Error')
            model.error = RunError.from_json_hash(json['Error'])
          end

          if json.has_key?('BuildInfo')
            model.build_info = RunBuildInfo.from_json_hash(json['BuildInfo'])
          end

          unless model.start_time.nil? || model.end_time.nil? || !model.start_time.is_a?(DateTime) || !model.end_time.is_a?(DateTime)
            model.duration = ((model.end_time - model.start_time) * 24 * 60 * 60).to_i
          end

          model
        end
      end
    end

    # Represents the details of a run's associated build.
    class RunBuildInfo
      # @return [String] Name of the build.
      attr_accessor :build_name

      # @return [String] Id of the build.
      attr_accessor :build_id

      # @return [String] Url to the build information.
      attr_accessor :build_url

      # @return [Hash] A JSON'able hash representation of the entity.
      def as_json
        { BuildName: @build_name,
          BuildId: @build_id,
          BuildUrl: @build_url }
      end

      class << self
        # Returns a model instance from a JSON hash.
        #
        # @param hash [Hash] The JSON hash.
        #
        # @return [RunBuildInfo]
        def from_json_hash(hash)
          model = new

          model.build_name = hash['BuildName']
          model.build_id = hash['BuildId']
          model.build_url = hash['BuildUrl']

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
      def as_json
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

          model.file_name = hash['FileName']
          model.error_type = hash['ErrorType']
          model.line_number = hash['LineNumber']
          model.message = hash['Message']
          model.stack_trace.concat(hash['StackTrace'])

          model
        end
      end
    end
  end
end