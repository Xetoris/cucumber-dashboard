require 'mongoid'
class Regression
  include Mongoid::Document

  field :st, as: :status, type: String
  field :nm, as: :name, type: String

  embeds_many :run, store_as: :rns
end

class Run
  include Mongoid::Document

  field :st, as: :status, type: String
  field :exid, as: :execution_id
  field :ftn, as: :feature_name, type: String
  field :ftid, as: :feature_id
  field :dur, as: :duration

  embedded_in :regression
end