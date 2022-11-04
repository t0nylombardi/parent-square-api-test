# frozen_string_literal: true
require 'httparty'

# algorithm for the weighted random url call was taken by emumberabl#max_by
# Note: Not sure how to test the weighted call via rspec. However here is 
# an example on how to test the algoruthm via console: 
#    y = { 1 => 0.7, 2 => 0.3 }
#    wrs = -> { y.max_by { |_, weight| rand ** (1.0/weight) }.first }
#    100.times.each_with_object(Hash.new(0)) { |_, freq| freq[wrs.call] += 1 }
#    # => {2=>29, 1=>71}

# see https://rubyapi.org/2.7/o/enumerable#method-i-max_by
class MessageService < ApplicationService

  API_URL = 'https://mock-text-provider.parentsquare.com/provider'
  WEIGHTS = { 1 => 0.3, 2 => 0.7 }.freeze

  def initialize(phone_number, message)
    @phone_number = phone_number
    @message = message
  end

  def execute!
    tries = 0
    begin
      # lambda that randomly returns a key from WEIGHTS in proportion to its weight
      wrs = -> { WEIGHTS.max_by { |_, weight| rand ** (1.0 / weight) }.first }
      HTTParty.post("#{API_URL}/#{wrs.call}",
                    body: {
                      to_number: @phone_number,
                      message: @message,
                      callback_url: 'http://localhost:3000/callback'
                    })
    rescue HTTParty::Error
      tries += 1
      retry if tries <= 3
      Rails.logger.info 'API not available'
    end
  end
end
