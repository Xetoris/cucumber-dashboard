require_relative 'base_entity'

module Dashboard
  module Entities
    # Represents a single Cucumber Scenario run.
    class Run < BaseEntity
      attr_accessor :name, :feature, :status, :tags, :steps
    end

    # Represents a Cucumber Step
    class Step
      attr_accessor :name, :location, :status, :exception

      def ==(other)
        @name == other.name && @location == other.location && @status == other.status && @exception == other.exception
      end
    end
  end
end