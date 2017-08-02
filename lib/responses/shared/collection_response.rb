module CucumberDashboard
  module Response
    module Shared
      # Represents the wrapper for a collection response.
      class CollectionResponse
        # @return [Integer] Number of available records.
        attr_accessor :count

        # @return [Integer] Ending index for snapshot of collection.
        attr_accessor :end

        # @return [Array<Object>] The list of entities retrieved.
        attr_reader :list

        # @return [String] Name of the field for sorting order.
        attr_accessor :sort

        # @return [Integer] Starting index for snapshot of collection.
        attr_accessor :start

        def initialize
          @list = []
        end

        # @return [Hash] Returns a JSON'able hash representing the entity.
        def to_json
          json = { Count: @count,
                   End: @end,
                   Sort: @sort,
                   Start: @start }

          array = []
          @list.each do |entity|
            array.push(entity.to_json) if entity.respond_to?(:to_json)
          end

          json[:List] = array
        end
      end
    end
  end
end