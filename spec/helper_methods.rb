require 'rspec/expectations'

module HelperMethods


  # Validates that an api error message was returned for the given key
  #
  # @param [Hash] errors - errors collection returned from API
  # @param [String] error_key - the key for the error in the collection
  # @param [String] message - the expected error message
  def validate_api_error_entry(errors, error_key, message)
    error = errors.find{ |key, value| key == error_key }

    expect(error).to_not be nil

    messages = error[1]

    if messages.first.is_a?(Array)
      expect(messages.any?{|c_key, c_value| c_value.include?(message)}).to be true
    else
      expect(messages).to include(message)
    end
  end
end