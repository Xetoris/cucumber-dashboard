require_relative '../entities/feature'
require_relative '../representations/feature_rep'

class FeatureRepository
  def self.get_features
    pre_call
    get_result_array(Feature.all)
  end

  def self.get_features_by_tag(tag_name)
    pre_call
    get_result_array(Feature.where(tgs: tag_name))
  end

  def self.get_feature_by_id(id)
    pre_call
    get_result(Feature.find(id))
  end

  private

  # Let's configure Mongoid if it hasn't been yet.
  def self.pre_call
    unless Mongoid.configured?
      Mongoid.load!(ENV['MONGOID_YML_PATH'])
    end
  end

  # We create a representation of the Mongo entity to limit access to Mongo to the Repository level.
  def self.get_result_array(mongo_result)
    mongo_result.map{|ftr| FeatureRep.new.populate_from_model(ftr)}
  end

  # We create a representation of the Mongo entity to limit access to Mongo to the Repository level.
  def self.get_result(mongo_result)
    FeatureRep.new.populate_from_model(mongo_result)
  end
end