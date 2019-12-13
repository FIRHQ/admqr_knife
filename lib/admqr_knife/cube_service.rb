# frozen_string_literal: true

module AdmqrKnife
  class CubeService < DefaultRest
    class << self
      def basic_url
        AdmqrKnife.knife_base_uri
      end

      def base_params
        {
          knife_client_key: AdmqrKnife.knife_client_key,
          gem_version: AdmqrKnife::VERSION
        }
      end
    end

  end
end
