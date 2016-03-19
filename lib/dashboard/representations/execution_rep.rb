require_relative 'mongo_rep'

class ExecutionRep < MongoRep
  attr_accessor :status, :feature, :scenarios, :id

  def populate_from_model(execution)
    @id = execution._id.to_s
    @status = execution.st unless execution.st.nil?

    unless execution.ftr.nil?
      @feature = {
          :id => execution.ftr['id'].to_s,
          :name => execution.ftr['name']
      }
    end

    unless execution.scenarios.nil? || execution.scenarios.empty?
      @scenarios = []

      execution.scenarios.each do |scenario|
        @scenarios.push(ScenarioRep.new.populate_from_model(scenario))
      end
    end

    self
  end
end

class ScenarioRep < MongoRep
  attr_accessor :name, :tags, :steps

  def populate_from_model(scenario)
    @name = scenario.nm unless scenario.nm.nil?
    @tags = scenario.tgs unless scenario.tgs.nil?

    unless scenario.steps.nil? || scenario.steps.empty?
      @steps = []

      scenario.steps.each do |step|
        @steps.push(StepRep.new.populate_from_model(step))
      end
    end

    self
  end
end

class StepRep < MongoRep
  attr_accessor :description, :status, :definition, :exception, :backtrace, :step_type

  def populate_from_model(step)
    @description = step.dsc unless step.dsc.nil?
    @status = step.st unless step.st.nil?
    @definition = step.def unless step.def.nil?
    @exception = step.exc unless step.exc.nil?
    @backtrace = step.bkt unless step.bkt.nil?
    @step_type = step.styp unless step.styp.nil?

    self
  end
end