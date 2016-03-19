class MongoRep
  def populate_from_model
    raise('Model did not implement populate_from_model. Please override this method to make rep model binding work.')
  end
end