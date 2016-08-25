require 'hanami-validations'

class ExceptionValidator
  include Hanami::Validations

  validations do
    required(:message).filled(:str?)
    optional(:backtrace).each(:str?)
  end
end

class StepValidator
  include Hanami::Validations

  validations do
    required(:name).filled(:str?)
    required(:location).filled(:str?)
    required(:status).filled(:str?, format?: /^(skipped|success|failed)$/)
    optional(:exception).schema(::ExceptionValidator)
  end
end

