class ExecutionRep
  attr_accessor :status, :feature, :scenarios

  def initialize(params = {})
    @status = params[:status] if params.has_key?(:status)
    @feature = params[:feature] if params.has_key?(:feature)

    if params.has_key?(:scenarios) && params[:scenarios].is_a?(Array)
      @scenarios = []

      params[:scenarios].each do |scenario|
        @scenarios.push(ScenarioRep.new(scenario))
      end
    end
  end

  def self.populate_from_model(execution)
    model = ExecutionRep.new

    model.status = execution.st unless execution.st.nil?
    model.feature = execution.ftr unless execution.ftr.nil?

    unless execution.scenarios.nil?
      execution.scenarios.each do |scenario|
        model.scenarios = []
        model.scenarios.push(ScenarioRep.populate_from_model(scenario))
      end
    end
  end
end

class ScenarioRep
  attr_accessor :name, :tags, :steps

  def initialize(params={})
    @name = params[:name] if params.has_key?(:name)
    @tags = params[:tags] if params.has_key?(:tags)

    if params.has_key?(:steps) && params[:steps].is_a?(Array)
      @steps = []

      params[:steps].each do |step|
        @steps.push(StepRep.new(step))
      end
    end
  end

  def self.populate_from_model(scenario)
    model = ScenarioRep.new

    model.name = scenario.nm unless scenario.nm.nil?
    model.tags = scenario.tgs unless scenario.tgs.nil?

    unless scenario.steps.nil?
      scenario.steps.each do |step|
        model.steps = []
        model.steps.push(StepRep.populate_from_model(step))
      end
    end
  end
end

class StepRep
  attr_accessor :description, :status, :definition, :exception, :backtrace, :step_type

  def initialize(params={})
    @description = params[:description] if params.has_key?(:description)
    @status = params[:status] if params.has_key?(:status)
    @definition = params[:definition] if params.has_key?(:definition)
    @exception = params[:exception] if params.has_key?(:exception)
    @backtrace = params[:backtrace] if params.has_key?(:backtrace) && params[:backtrace].is_a?(Array)
    @step_type = params[:step_type] if params.has_key?(:step_type)
  end

  def self.populate_from_model(step)
    model = StepRep.new

    model.description = step.dsc unless step.dsc.nil?
    model.status = step.st unless step.st.nil?
    model.definition = step.def unless step.def.nil?
    model.exception = step.exc unless step.exc.nil?
    model.backtrace = step.bkt unless step.bkt.nil?
    model.step_type = step.styp unless step.styp.nil?
  end
end