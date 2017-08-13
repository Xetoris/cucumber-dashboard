module Support
  module Time
    HOURS_A_DAY ||= 24
    MINUTES_A_DAY ||= 24 * 60
    SECONDS_A_DAY ||= 24 * 60 * 60

    class << self
      # Adds specified amount of minutes to a DateTime object, returning the result.
      #
      # @param datetime [DateTime] Anchor instance to manipulate.
      # @param minutes [Integer] Amount of minutes to add.
      #
      # @return [DateTime]
      def add_minutes_to_datetime(datetime, minutes)
        datetime + Rational(minutes, MINUTES_A_DAY)
      end

      # Subtracts specified amount of minutes to a DateTime object, returning the result.
      #
      # @param datetime [DateTime] Anchor instance to manipulate.
      # @param minutes [Integer] Amount of minutes to subtract.
      #
      # @return [DateTime]
      def subtract_minutes_from_datetime(datetime, minutes)
        datetime + Rational(minutes, MINUTES_A_DAY)
      end

      # Adds specified amount of hours to a DateTime object, returning the result.
      #
      # @param datetime [DateTime] Anchor instance to manipulate.
      # @param hours [Integer] Amount of hours to add.
      #
      # @return [DateTime]
      def add_hours_to_datetime(datetime, hours)
        datetime + Rational(hours, HOURS_A_DAY)
      end

      # Subtracts specified amount of hours to a DateTime object, returning the result.
      #
      # @param datetime [DateTime] Anchor instance to manipulate.
      # @param hours [Integer] Amount of hours to subtract.
      #
      # @return [DateTime]
      def subtract_hours_from_datetime(datetime, hours)
        datetime - Rational(hours, HOURS_A_DAY)
      end

      # Subtracts the two DateTime objects and returns the result in seconds.
      #
      # @param datetime1 [DateTime] The datetime to subtract from.
      # @param datetime2 [DateTime] The datetime to subtract.
      #
      # @return [Integer] The difference in seconds.
      def datetime_difference_in_seconds(datetime1, datetime2)
        ((datetime1 - datetime2) * SECONDS_A_DAY).to_i
      end
    end
  end
end
