# frozen_string_literal: true

require 'admqr_knife/version'
require 'api_tools'

module AdmqrKnife
  class Error < StandardError; end
  # Your code goes here...
  class << self
    attr_accessor :knife_api_token, :knife_base_uri, :logger

    def init(api_token = nil, options = {})
      @knife_api_token = api_token || ENV['ADMQR_KNIFE_API_TOKEN']
      @knife_base_uri = ENV['KNIFE_BASE_URI'] || 'https://www.admqr.com/apic/v1/'
      logger = options[:logger] || select_logger
    end

    def api_token
      @knife_api_token
    end

    def visit(unique_code:, **options)
      raise 'unique_code 不能为空' if unique_code.to_s == ''

      ua = options[:ua]
      referer = options[:referer]
      tag = options[:tag]
      new_to_visit = options[:new_to_visit]
      remote_ip = options[:remote_ip]
      CubeService.post('/api/knifes/statis',
                       unique_code: unique_code,
                       ua: ua,
                       referer: referer,
                       tag: tag,
                       new_to_visit: new_to_visit,
                       remote_ip: remote_ip)
    
    rescue StandardError => e
      # do nothiing
      logger.error e.message
    end

    private

    def select_logger
      return Rails.logger if defined? Rails

      Logger.new(STDOUT)
    end
  end
end
