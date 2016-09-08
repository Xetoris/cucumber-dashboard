require 'hanami-validations'
require 'hanami/action/params'
require_relative 'step_validator'

class RunValidator < Api::Action::Params

  params do
    required(:feature).filled(:str?, format?: /^[a-zA-Z0-9\s\/_-]*$/)
    required(:name).filled(:str?, format?: /^[a-zA-Z0-9\s\/_-]*$/)
    required(:status).filled(:str?, format?: /^(skipped|passed|failed)$/)
    optional(:tags).filled(:array?) do |opts|
      opts.each(:str?, format?:/^@[a-zA-Z0-9_-]*$/)
    end
    #optional(:steps).filled(:array?) do |opts|
    #  opts.each(schema: StepValidator)
    #end
  end
end