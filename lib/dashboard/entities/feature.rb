require 'mongoid'

class Feature
  include Mongoid::Document

  field :tgs, as: :tags, type: Array
  field :src, as: :source, type: String
  field :nm, as: :name, type: String
  field :dcr, as: :description, type: String
end