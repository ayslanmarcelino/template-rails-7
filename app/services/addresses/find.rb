module Addresses
  class Find < ApplicationService
    def initialize(zip_code:)
      @zip_code = zip_code.gsub(/\W+/, '')
    end

    def call
      find
    end

    private

    def find
      parsed_response.presence || {}
    end

    def parsed_response
      return if response.blank?

      @parsed_response ||= JSON.parse(response.body)
    end

    def response
      @response ||= RestClient.get(url)
    rescue StandardError => e
      Rollbar.error(e, 'Não foi possível consultar o endereço', request: url, zip_code: @zip_code)
      nil
    end

    def url
      "#{ENV['ADDRESS_PROVIDER']}#{@zip_code}/json"
    end
  end
end
