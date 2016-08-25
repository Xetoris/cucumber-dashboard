require 'hanami-validations'
require 'hanami/action/params'
require_relative 'step_validator'

class RunValidator < Api::Action::Params
  include Hanami::Validations

  params do
    required(:feature).filled(:str?, format?: /^[a-zA-Z0-9\s\/_-]*$/)
    required(:name).filled(:str?, format?: /^[a-zA-Z0-9\s\/_-]*$/)
    required(:status).filled(:str?, format?: /^(skipped|success|failed)$/)
    optional(:tags).each(:str?, format?:/^@[a-zA-Z0-9_-]*$/)
    optional(:steps).each(schema: StepValidator)
  end
end