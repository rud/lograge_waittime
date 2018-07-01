# frozen_string_literal: true

require 'test_helper'

module LogrageRailsRequestQueuing
  class RequestStartedMiddlewareTest < ActiveSupport::TestCase
    test 'middleware is installed' do
      assert Rails.application.middleware.include?(
        LogrageRailsRequestQueuing::RequestStartedMiddleware
      )
    end
  end
end
