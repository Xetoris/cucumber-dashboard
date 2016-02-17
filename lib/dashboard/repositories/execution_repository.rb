require_relative 'mongo_repository'
require_relative '../entities/execution'
require_relative '../representations/execution_rep'

class ExecutionRepository < MongoRepository
  def initialize
    super(ExecutionRep)
  end

  def get_executions
    get_result_array(Execution.all)
  end

  def get_executions_by_feature_name(name)
    get_result_array(Execution.where('ftr.name' => name))
  end

  def get_execution(id)
    get_result(Execution.find(id))
  end
end