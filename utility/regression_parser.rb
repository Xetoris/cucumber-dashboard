require 'mongoid'
require 'json'

require_relative '../lib/dashboard/mongo_entities/execution'
require_relative '../lib/dashboard/mongo_entities/feature'
require_relative '../lib/dashboard/mongo_entities/regression'

class RegressionParser
  def initialize(config_path, file_path)
    @config = config_path
    @file = file_path
  end

  def parse_to_mongo
    # Set Mongo config
    Mongoid.load!(@config)

    # Load our JSON file
    data = JSON.parse(File.read(@file))

    total = data.count

    data.each_index do |index|
      feature_json = data[index]

      # The Feature Record
      feature = get_feature(feature_json)

      feature.save!

      # Execution Record
      execution = get_execution(feature_json, feature)

      execution.save!

      puts("Finishing #{index + 1} of #{total}")
    end
  end

  def get_feature(json)
    source = json['source'].scan(/cucumber-web\S*.feature/).first
    feature_name = source.split('/').last.split('.feature')[0]

    feature = Feature.find_or_initialize_by(name: feature_name)

    feature.nm = feature_name
    feature.src = source

    if json.has_key?('tags')
      tags = json['tags']
      # ToDo: Remove .first when I fix bug with formatter to record this as an array instead of array of arrays
      feature.tgs = tags.first if tags.any?
    end

    if json.has_key?('description')
      description = json['description']
      feature.description = description unless description.nil? || description.empty?
    end

    feature
  end

  def get_execution(json, feature)
    execution = Execution.new
    execution.ftr = { :name => feature.nm, :id => feature._id  }

    execution.st = 'passed'

    json['scenarios'].each do |scenario_json|
      # The Scenario
      pop_scenario(scenario_json, execution)
    end

    execution
  end

  def pop_scenario(json, execution)
    scenario = execution.scenarios.new

    scenario.nm = json['name']

    if json.has_key?('tags')
      tags = json['tags'].first
      scenario.tgs = tags if tags.any?
    end

    json['history'].each do |step_json|
      pop_step(step_json, scenario, execution)
    end
  end

  def pop_step(json, scenario, execution)
    step = scenario.steps.new

    step.styp = json['type']

    if json.has_key?('text')
      text = json['text']
      step.dsc = text unless text.nil? || text.empty?
    end

    if json.has_key?('status')
      status = json['status']

      unless status.nil? || status.empty?
        step.st = status

        # if execution is already marked failed, doesn't matter what other steps are set to.
        execution.st = status if execution.st != 'failed'
      end
    end

    if json.has_key?('definition')
      definition = json['definition']
      step.def = definition unless definition.nil? || definition.empty?
    end

    if json.has_key?('exception')
      exc = json['exception']
      step.exc = exc unless exc.nil? || exc.empty?
    end

    if json.has_key?('backtrace')
      backtrace = json['backtrace']
      step.bkt = backtrace if backtrace.any?
    end
  end
end