require_relative 'base_entity'

module Dashboard
  module Entities
    # Represents a single Cucumber Scenario run.
    class Run < BaseEntity
      attr_accessor :name, :feature, :status, :tags, :steps

      def self.json_create(o)
        new(*o['data'])
      end

      def to_json(*a)
        {
            :id => @id,
            :name => @name,
            :feature => @feature,
            :status => @status,
            :tags => @tags,
            :steps => @steps.collect{|x| x.to_hash}
        }.to_json(*a)
      end
    end

    # Represents a Cucumber Step
    class Step
      attr_accessor :name, :location, :status, :exception

      def ==(other)
        @name == other.name && @location == other.location && @status == other.status && @exception == other.exception
      end

      def to_hash
        {
            :name => @name,
            :location => @location,
            :status => @status,
            :exception => @exception
        }
      end

      def to_json(*a)
        to_hash.to_json(*a)
      end
    end
  end
end