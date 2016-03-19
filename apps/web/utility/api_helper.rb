require 'rest-client'

module Web
  module Utility
    module ApiHelper
      def api_get(path)
        RestClient.get(api_get_full_path(path))
      end

      def api_post(path, body={})
        RestClient.post(api_get_full_path(path), body)
      end

      def api_put(path, body={})
        RestClient.put(api_get_full_path(path), body)
      end

      def api_delete(path)
        RestClient.delete(api_get_full_path(path))
      end


      def api_get_full_path(relative_path)
        "http://#{Web::Application.configuration.host}:#{Web::Application.configuration.port}/api/#{relative_path}"
      end
    end
  end
end