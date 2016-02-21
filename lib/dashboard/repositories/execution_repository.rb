require_relative 'mongo_repository'
require_relative '../entities/execution'
require_relative '../representations/execution_rep'

class ExecutionRepository < MongoRepository
  def initialize
    super(ExecutionRep)
  end

  def get_executions_with_query(props={})
    query = Execution

    if props.include?('feature_id') && !props['feature_id'].empty?
      query = query.where('ftr.id' => BSON::ObjectId(props['feature_id']))
    elsif props.include?('feature_name') && !props['feature_name'].empty?
      query = query.where('ftr.name' => props['feature_name'])
    end

    if props.include?('status') && !props['status'].empty?
      query = query.where('st' => props['status'])
    end

    get_result_array(query.without(:scs))
  end


  def get_execution_by_id(id)
    get_result(Execution.find(id))
  end
end