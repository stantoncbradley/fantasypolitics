require 'net/http'
require 'open-uri'

class Sunlight



  BASE_URL        = "https://congress.api.sunlightfoundation.com/"
  API_KEY         = '146a7f07a1104cdf8e298db177d42b22'
  REQUEST_TIMEOUT = 10 #seconds
  REQUEST_RETRIES = 2
  PER_PAGE        = 50 #This is the max Sunlight allows



  # Performs an API request
  #
  # @param request  the action
  # @return JSON object with result
  #
  def self.call_api(request, page)
    url = BASE_URL + request + "?apikey=" + API_KEY + "$per_page=" + PER_PAGE + "&page=" + page.to_s
    uri = URI.parse(url)

    http = Net::HTTP.new uri.host, uri.port
    http.use_ssl = true

    timeout_and_retry(request) do
      req = Net::HTTP::Get.new uri.request_uri
      @resp = http.request req
    end

    unless @error
      json = JSON.parse(@resp.body)
    end

    json.symbolize_keys
  end



  # Attempt a task up to REQUEST_RETRIES time, with REQUEST_TIMEOUT timeout per 
  # attempt.  If process still does not complete, log error.
  #
  # @param  string  request   URL being requested
  #
  def self.timeout_and_retry(request)
    @retries = 1
    begin
      Timeout::timeout(REQUEST_TIMEOUT) { yield }
    rescue Timeout::Error
      @retries += 1
      if (@retries) > REQUEST_RETRIES
        @error = true
        Rails.logger.error "TIMEOUT :: on request " + request.to_s
        return
      end
      retry
    end
  end



end #class
