# frozen_string_literal: true

module AdmqrKnife
  class CubeService < DefaultRest
    class << self
      def basic_url
        AdmqrKnife.base
      end

      def base_params
        {
          api_token: AdmqrKnife.knife_api_token,
          gem_version: AdmqrKnife::VERSION 
        }
      end
    end

  end
end
