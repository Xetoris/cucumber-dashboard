module Dashboard
  module Entities
    class BaseEntity
      attr_accessor :id

      def initialize(id = nil)
        @id = id unless id.nil? || id.empty?
      end

      def to_mongo_model
        nil
      end
    end
  end
end