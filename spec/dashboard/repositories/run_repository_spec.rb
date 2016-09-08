require 'rspec/expectations'
require_relative '../../spec_helper'
require_relative '../../../lib/dashboard/entities/run'
require_relative '../../../lib/dashboard/repositories/run_repository'

RSpec.describe Dashboard::Repositories::RunRepository do
  before(:all)  do
    @client = described_class.new
  end

  it 'can store a run' do
    step_model = Dashboard::Entities::Step.new

    step_model.name = 'Test Step'
    step_model.location = '/some/place/here'
    step_model.status = 'passed'


    model = Dashboard::Entities::Run.new

    model.create_date = Time.now
    model.name = "#{ Faker::Company.buzzword } Scenario"
    model.feature = "#{ Faker::Company.buzzword } Feature"
    model.status = 'passed'
    model.tags = %w(@tag1 @tag_test)
    model.steps = [step_model]
    model.regression_tag = 'jenkins-regression.qa.some.suite-12'

    result = @client.add_run(model)

    expect(result).to_not be nil
    expect(result.empty?).to be false
    expect(model.id).to_not be nil
    expect(model.id.empty?).to be false
    expect(model.id).to eq(result)
  end

  describe 'retrieval' do
    before(:all) do
      step_model = Dashboard::Entities::Step.new

      step_model.name = 'Given I do something'
      step_model.location = '/features/steps/step_file.rb'
      step_model.status = 'passed'

      model = Dashboard::Entities::Run.new

      model.create_date = Time.now
      model.name = "#{ Faker::Company.buzzword } Scenario"
      model.feature = "#{ Faker::Company.buzzword } Feature"
      model.status = 'passed'
      model.tags = ["@#{Faker::Company.profession.gsub(' ', '_')}"]
      model.steps = [step_model]
      model.regression_tag = "jenkins-regression.qa.#{ Faker::Company.buzzword.downcase }.suite-#{ Random.new.rand(1..99) }"

      @client.add_run(model)

      expect(model).to_not be nil

      @stored_model = model
    end

    it 'can retrieve a run by id' do
      retrieved = @client.get_run(@stored_model.id)

      expect(retrieved.id).to eq(@stored_model.id)
      expect(retrieved.name).to eq(@stored_model.name)
      expect(retrieved.feature).to eq(@stored_model.feature)
      expect(retrieved.regression_tag).to eq(@stored_model.regression_tag)
      expect(retrieved.status).to eq(@stored_model.status)
      expect(retrieved.tags).to eq(@stored_model.tags)
      expect(retrieved.steps).to eq(@stored_model.steps)
    end

    it 'can retrieve runs' do
      retrieved = @client.get_runs

      expect(retrieved.count).to be > 0
    end

    it 'can retrieve sorted desc' do
      retrieved = @client.get_runs(sort_options: {:direction => 'desc'})

      expect(retrieved.count).to be > 0

      sorted = retrieved.sort { |x,y| y.create_date <=> x.create_date }.collect { |x| x.id }

      expect(retrieved.collect{ |x| x.id }).to eq(sorted)
    end

    it 'can retrieve sorted asc' do
      retrieved = @client.get_runs(sort_options: {:direction => 'asc'})

      expect(retrieved.count).to be > 0

      sorted = retrieved.sort { |x,y| x.create_date <=> y.create_date }.collect { |x| x.id }

      expect(retrieved.collect{ |x| x.id }).to eq(sorted)
    end

    it 'can search by name' do
      retrieved = @client.get_runs(filter_options: {:nm => @stored_model.name})

      expect(retrieved.count).to be > 0
      expect(retrieved.find{ |run| run.id == @stored_model.id }).to_not be nil
    end

    it 'can search by feature name' do
      retrieved = @client.get_runs(filter_options: {:ftr => @stored_model.feature})

      expect(retrieved.count).to be > 0
      expect(retrieved.find{ |run| run.id == @stored_model.id }).to_not be nil
    end

    it 'can search by regression tag' do
      retrieved = @client.get_runs(filter_options: { :rtg => @stored_model.regression_tag })

      expect(retrieved.count).to be > 0
      expect(retrieved.find{ |run| run.id == @stored_model.id }).to_not be nil
    end

    it 'can return a list of distinct names' do
      test_names = @client.get_run_names

      expect(test_names.count).to be > 0
      expect(test_names.find{ |name| name == @stored_model.name }).to_not be nil
    end

    it 'can return a list of distinct features' do
      test_names = @client.get_run_features

      expect(test_names.count).to be > 0
      expect(test_names.find{ |name| name == @stored_model.feature }).to_not be nil
    end
  end
end