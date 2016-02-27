require_relative '../../utility/api_helper'

module Web::Controllers::Features
  class FeatureDetail
    include Web::Action
    include Web::Utility::ApiHelper

    expose :feature, :executions, :success_percent

    params do
      param :id, presence: true
    end

    def call(params)
      @feature = JSON.parse(api_get("features/#{params[:id]}"))
      @executions = JSON.parse(api_get("executions?feature_id=#{params[:id]}"))

      passed = @executions.select {|x| x['status'] == 'passed'}.count
      @success_percent = "#{(passed / @executions.count) * 100}%"
    end
  end
end