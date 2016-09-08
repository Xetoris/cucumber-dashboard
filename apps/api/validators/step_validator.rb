require 'hanami-validations'
require 'hanami/action/params'

class ExceptionValidator < Api::Action::Params
  params do
    required(:message).filled(:str?)
    optional(:backtrace).filled(:array?) do |opts|
      opts.each(:str?)
    end
  end
end

class StepValidator < Api::Action::Params

  params do
    required(:name).filled(:str?)
    required(:location).filled(:str?)
    required(:status).filled(:str?, format?:(/^(skipped|success|failed)$/))
    optional(:exception).filled(:array?) do |opts|
      opts.each(schema: ExceptionValidator)
    end
  end
end
