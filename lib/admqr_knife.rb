# frozen_string_literal: true

require 'admqr_knife/version'
require 'api_tools'
# require 'byebug'
require_relative './admqr_knife/cube_service'

module AdmqrKnife
  class Error < StandardError; end
  # Your code goes here...
  class << self
    attr_accessor :knife_client_key, :knife_base_uri, :logger

    def init(client_key = nil, options = {})
      @knife_client_key = client_key || ENV['ADMQR_KNIFE_CLIENT_KEY'] 
      @knife_base_uri = ENV['KNIFE_BASE_URI'] || 'https://www.admqr.com/apic/v1/'
      @logger = options[:logger] || select_logger
    end

    def client_key
      @knife_client_key
    end

    def visit(unique_code:, **options)
      raise 'unique_code 不能为空' if unique_code.to_s == ''

      ua = options[:ua]
      referer = options[:referer]
      tag = options[:tag]
      new_to_visit = options[:new_to_visit]
      remote_ip = options[:remote_ip]
      CubeService.post('/api/knifes/statis',
                       { unique_code: unique_code,
                         client_ua: ua,
                         referer: referer,
                         tag: tag,
                         new_to_visit: new_to_visit,
                         remote_ip: remote_ip }.reject! { |_k, v| v.nil? })
    rescue StandardError => e
      logger.error e.message
    end

    private

    def select_logger
      return Rails.logger if defined? Rails

      Logger.new(STDOUT)
    end
  end
end
