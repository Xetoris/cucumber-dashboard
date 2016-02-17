class FeatureRep
  attr_accessor :tags, :source, :name, :description, :id

  def initialize(params={})
    @id = params[:id] if params.has_key?(:id)
    @tags = params[:tags] if params.has_key?(:tags)
    @source = params[:source] if params.has_key?(:source)
    @name = params[:name] if params.has_key?(:name)
    @description = params[:description] if params.has_key?(:description)
  end

  def self.populate_from_model(feature)
    model = FeatureRep.new

    model.id = feature._id.to_s

    unless feature.tgs.nil? || feature.tgs.empty?
      model.tags = feature.tgs
    end

    model.name = feature.nm unless feature.nm.nil?
    model.source = feature.src unless feature.src.nil?
    model.description = feature.dcr unless feature.dcr.nil?

    model
  end
end