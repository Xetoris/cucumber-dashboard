require_relative 'mongo_repository'
require_relative '../entities/feature'
require_relative '../representations/feature_rep'

class FeatureRepository < MongoRepository
  def initialize
    super(FeatureRep)
  end

  def get_features_with_query(props = {})
    query = Feature

    if props.include?('name') && !props['name'].empty?
      query = query.where('nm' => props['name'])
    end

    if props.include?('tags') && !props['tags'].empty?
      values = []
      props['tags'].split(',').each do |tag|
        tag.strip!

        next if tag.empty?

        values.push(tag)
      end

      query = query.where('tgs': { '$all': values })
    end

    get_result_array(query.is_a?(Class) ? query.all : query)
  end

  def get_feature_by_id(id)
    get_result(Feature.find(id))
  end
end