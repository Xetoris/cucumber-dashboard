require_relative 'mongo_repository'
require_relative '../entities/feature'
require_relative '../representations/feature_rep'

class FeatureRepository < MongoRepository
  def initialize
    super(FeatureRep)
  end

  def get_features
    get_result_array(Feature.all)
  end

  def get_features_by_tag(tag_name)
    get_result_array(Feature.where(tgs: tag_name))
  end

  def get_feature_by_id(id)
    get_result(Feature.find(id))
  end
end