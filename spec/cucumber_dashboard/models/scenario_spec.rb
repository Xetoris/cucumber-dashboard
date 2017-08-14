require_relative '../../spec_helper'

RSpec.describe CucumberDashboard::Models::Scenario do
  context 'with a json string' do
    let(:json_string) { '{ "FeatureName":"RspecFeature", "FileName":"scenario_spec.rb", "Id":"A1B2C3", "Name":"RspecTest", "RelativePath":"cucumber_dashboard/spec/cucumber_dashboard/models/", "StepCount":"10", "Tags":["@rspec", "@test", "@cucumber"]  }' }

    it 'can load from a json string' do
      test = described_class.from_json(json_string)

      expect(test).to_not be nil
      expect(test.feature_name).to eq 'RspecFeature'
      expect(test.file_name).to eq 'scenario_spec.rb'
      expect(test.id).to eq 'A1B2C3'
      expect(test.name).to eq 'RspecTest'
      expect(test.relative_path).to eq 'cucumber_dashboard/spec/cucumber_dashboard/models/'
      expect(test.step_count).to eq '10'
      expect(test.tags.count).to eq 3
      expect(test.tags).to contain_exactly('@rspec', '@test', '@cucumber')
    end
  end
end