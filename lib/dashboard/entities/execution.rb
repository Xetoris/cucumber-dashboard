require 'mongoid'

class Execution
  include Mongoid::Document

  field :st, as: :status, type: String
  field :ftr, as: :feature, type: Hash

  embeds_many :scenarios, store_as: :scs
end

class Scenario
  include Mongoid::Document

  field :nm, as: :name, type: String
  field :tgs, as: :tags, type: Array

  embedded_in :execution
  embeds_many :steps, store_as: :sps
end

class Step
  include Mongoid::Document

  field :dsc, as: :description, type: String
  field :st, as: :status, type: String
  field :def, as: :definition, type: String
  field :exc, as: :exception, type: String
  field :bkt, as: :backtrace, type: Array
  field :styp, as: :step_type, type: String

  embedded_in :scenario
end