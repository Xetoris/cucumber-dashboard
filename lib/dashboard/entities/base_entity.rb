module Dashboard
  module Entities
    class BaseEntity
      attr_accessor :id, :create_date

      def ==(other_base)
        @id == other_base.id
      end
    end
  end
end