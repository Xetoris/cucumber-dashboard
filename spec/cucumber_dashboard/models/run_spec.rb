require_relative '../../spec_helper'

RSpec.describe CucumberDashboard::Models::Run do
  context 'with a json string' do
    let (:start_time) { DateTime.new(2017, 8, 6, 22, 20, 0, '-4') }
    let (:end_time) { Support::Time.add_minutes_to_datetime(start_time, 20) }
    let (:json_empty) { '{}' }
    let (:json_bare) { "{\"EndTime\" : \"#{end_time.to_s}\", \"StartTime\" : \"#{start_time.to_s}\", \"ScenarioId\":\"123\", \"Status\":\"1\"}" }
    let (:json_w_build) { '{ "ScenarioId":"123", "Status":"1", "BuildInfo":{ "BuildId":"A12B34C56", "BuildName":"RspecTest", "BuildUrl":"http://www.google.com" } }' }
    let (:json_w_error) { '{ "ScenarioId":"123", "Error":{ "FileName":"cucumber_dashboard/spec/cucumber_dashboard/models/run_spec.rb", "ErrorType":"Silly", "LineNumber":"123", "Message":"My Test Message", "StackTrace":["Test1", "Test2", "Test3"] } }' }
    let (:json_wo_end_date) { "{ \"StartTime\":\"#{start_time.to_s}\", \"ScenarioId\":\"123\", \"Status\":\"1\" }" }

    it 'can load from an empty json string' do
      test = described_class.from_json(json_empty)
      expect(test.build_info).to be nil
      expect(test.duration).to be nil
      expect(test.end_time).to be nil
      expect(test.error).to be nil
      expect(test.scenario_id).to be nil
      expect(test.start_time).to be nil
      expect(test.status).to be nil
      expect(test.status_name).to be nil
    end

    it 'can load from a bare json string' do
      test = described_class.from_json(json_bare)
      expect(test.build_info).to be nil
      expect(test.error).to be nil
      expect(test.scenario_id).to_not be nil
      expect(test.scenario_id).to eq ('123')
      expect(test.status).to_not be nil
      expect(test.status).to eq ('1')
      expect(test.end_time).to_not be nil
      expect(test.end_time).to eq (end_time)
      expect(test.start_time).to_not be nil
      expect(test.start_time).to eq (start_time)
      expect(test.duration).to_not be nil
      expect(test.duration).to eq (Support::Time.datetime_difference_in_seconds(test.end_time, test.start_time))
      # expect(test.status_name).to be nil
    end

    it 'can load from a json string with build info' do
      test = described_class.from_json(json_w_build)

      expect(test.build_info).to_not be nil
      expect(test.build_info.build_name).to eq 'RspecTest'
      expect(test.build_info.build_id).to eq 'A12B34C56'
      expect(test.build_info.build_url).to eq 'http://www.google.com'
      expect(test.error).to be nil
      expect(test.scenario_id).to_not be nil
      expect(test.scenario_id).to eq '123'
      expect(test.end_time).to be nil
      expect(test.start_time).to be nil
      expect(test.status).to eq '1'
      expect(test.duration).to be nil
    end

    it 'can load from a json string with an error' do
      test = described_class.from_json(json_w_error)

      expect(test.build_info).to be nil
      expect(test.error).to_not be nil
      expect(test.error.file_name).to eq 'cucumber_dashboard/spec/cucumber_dashboard/models/run_spec.rb'
      expect(test.error.error_type).to eq 'Silly'
      expect(test.error.line_number).to eq '123'
      expect(test.error.message).to eq 'My Test Message'
      expect(test.error.stack_trace.length).to eq 3
      expect(test.error.stack_trace).to contain_exactly('Test1','Test2','Test3')
      expect(test.scenario_id).to_not be nil
      expect(test.scenario_id).to eq '123'
      expect(test.end_time).to be nil
      expect(test.start_time).to be nil
      expect(test.status).to be nil
      expect(test.duration).to be nil
    end

    it 'can load from a json string without an ending date' do
      test = described_class.from_json(json_wo_end_date)

      expect(test.build_info).to be nil
      expect(test.error).to be nil
      expect(test.scenario_id).to_not be nil
      expect(test.scenario_id).to eq '123'
      expect(test.end_time).to be nil
      expect(test.start_time).to eq (start_time)
      expect(test.status).to eq '1'
      expect(test.duration).to be nil
    end
  end
end