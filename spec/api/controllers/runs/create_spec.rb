require 'rspec'
require 'multi_json'
require_relative '../../../spec_helper'
require_relative '../../../../apps/api/controllers/runs/create'
require_relative '../../../helper_methods'

RSpec.configure do |c|
  c.include HelperMethods
end

describe Api::Controllers::Runs::Create do
  let(:action) { described_class.new }
  let(:params) { {} }

  it 'validates an empty response' do
    response = action.call(params)
    expect(response[0]).to eq(400)

    errors = MultiJson.load(response[2].first)

    validate_api_error_entry(errors, 'feature', 'is missing')
    validate_api_error_entry(errors, 'name', 'is missing')
    validate_api_error_entry(errors, 'status', 'is missing')
  end

  it 'validates when name is missing' do
    params['feature'] = 'Feature Test'
    params['status'] = 'passed'

    response = action.call(params)
    expect(response[0]).to eq(400)

    errors = MultiJson.load(response[2].first)

    validate_api_error_entry(errors, 'name', 'is missing')
  end

  it 'validates when feature is missing' do
    params['name'] = 'Scenario Test'
    params['status'] = 'passed'

    response = action.call(params)
    expect(response[0]).to eq(400)

    errors = MultiJson.load(response[2].first)

    validate_api_error_entry(errors, 'feature', 'is missing')
  end

  it 'validates when status is missing' do
    params['name'] = 'Scenario Test'
    params['feature'] = 'Feature Test'

    response = action.call(params)
    expect(response[0]).to eq(400)

    errors = MultiJson.load(response[2].first)

    validate_api_error_entry(errors, 'status', 'is missing')
  end

  it 'passes validation with just the basics' do
    params['name'] = 'Scenario Test'
    params['feature'] = 'Feature Test'
    params['status'] = 'passed'
    params['regression_tag'] = 'jenkins-regression.qa.some.regression-12'

    response = action.call(params)
    expect(response[0]).to eq(201)
    expect(response[1].any?{|key, value| key == 'X-CukeDash-RunId' && !value.nil? && !value.empty?})
  end

  it 'validates when an empty tags collection is provided' do
    params['name'] = 'Scenario Test'
    params['feature'] = 'Feature Test'
    params['status'] = 'passed'
    params['tags'] = []

    response = action.call(params)
    expect(response[0]).to eq(400)

    errors = MultiJson.load(response[2].first)

    validate_api_error_entry(errors, 'tags', 'must be filled')
  end

  it 'validates when an invalid tag is provided' do
    params['name'] = 'Scenario Test'
    params['feature'] = 'Feature Test'
    params['status'] = 'passed'
    params['tags'] = ['@pass', 'fail', '3']

    response = action.call(params)
    expect(response[0]).to eq(400)

    errors = MultiJson.load(response[2].first)

    validate_api_error_entry(errors, 'tags', 'is in invalid format')
  end

  # it 'validates when an empty steps collection is provided' do
  #   params['name'] = 'Scenario Test'
  #   params['feature'] = 'Feature Test'
  #   params['status'] = 'passed'
  #   params['tags'] = ['@pass']
  #   params['steps'] = []
  #
  #   response = action.call(params)
  #   expect(response[0]).to eq(400)
  #
  #   errors = MultiJson.load(response[2].first)
  #
  #   validate_api_error_entry(errors, 'steps', 'must be filled')
  # end

  # it 'validates when an empty step is provided' do
  #   params['name'] = 'Scenario Test'
  #   params['feature'] = 'Feature Test'
  #   params['status'] = 'passed'
  #   params['tags'] = ['@pass']
  #   params['steps'] = [{:exception => {:backtrace => []}}]
  #
  #   response = action.call(params)
  #   expect(response[0]).to eq(400)
  #
  #   errors = MultiJson.load(response[2].first)
  #
  #   validate_api_error_entry(errors, 'steps', 'must be a hash')
  # end

  # it 'validates when a step lacks a name' do
  #   params['name'] = 'Scenario Test'
  #   params['feature'] = 'Feature Test'
  #   params['status'] = 'passed'
  #   params['tags'] = ['@pass']
  #   params['steps'] = [{ :test => 'test' }]
  #
  #   response = action.call(params)
  #   expect(response[0]).to eq(400)
  #
  #   errors = MultiJson.load(response[2].first)
  #
  #   validate_api_error_entry(errors, 'steps', 'must be a hash')
  # end
end