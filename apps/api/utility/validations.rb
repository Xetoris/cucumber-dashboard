module Api
  module Utility
    class Validations
      def self.mongo_id
        /^[a-zA-Z0-9]*$/
      end

      def self.feature_name
        /^[a-zA-Z0-9_]*$/
      end

      def self.tag_csv
        /^[a-zA-Z0-9,@\s_]*$/
      end

      def self.text_only
        /^[a-zA-Z]*$/
      end
    end
  end
end