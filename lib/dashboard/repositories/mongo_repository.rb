class MongoRepository

  attr_reader :obj_type

  def initialize(obj_type)
    @obj_type = obj_type
    config_call
  end

  protected

  # We create a representation of the Mongo entity to limit access to Mongo to the Repository level.
  def get_result_array(mongo_result)
    mongo_result.map{|ftr| @obj_type.populate_from_model(ftr)}
  end

  # We create a representation of the Mongo entity to limit access to Mongo to the Repository level.
  def get_result(mongo_result)
    @obj_type.populate_from_model(mongo_result)
  end

  private

  # Let's configure Mongoid if it hasn't been yet.
  def config_call
    unless Mongoid.configured?
      Mongoid.load!(ENV['MONGOID_YML_PATH'])
    end
  end
end