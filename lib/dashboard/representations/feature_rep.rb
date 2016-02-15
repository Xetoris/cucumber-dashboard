class FeatureRep
  attr_reader :tags, :source, :name, :description, :id

  def initialize(params={})
    @id = params[:id] if params.has_key?(:id)
    @tags = params[:tags] if params.has_key?(:tags)
    @source = params[:source] if params.has_key?(:source)
    @name = params[:name] if params.has_key?(:name)
    @description = params[:description] if params.has_key?(:description)
  end

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