require_relative 'mongo_rep'

class FeatureRep < MongoRep
  attr_accessor :tags, :source, :name, :description, :id

  def populate_from_model(feature)
    @id = feature._id.to_s

    unless feature.tgs.nil? || feature.tgs.empty?
      @tags = feature.tgs
    end

    @name = feature.nm unless feature.nm.nil?
    @source = feature.src unless feature.src.nil?
    @description = feature.dcr unless feature.dcr.nil?

    self
  end
end