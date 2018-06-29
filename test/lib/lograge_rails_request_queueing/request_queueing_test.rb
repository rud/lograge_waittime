# frozen_string_literal: true

require 'test_helper'
require 'lograge_rails_request_queuing/request_queuing'

module LogrageRailsRequestQueuing
  class RequestQueuingTest < ActiveSupport::TestCase
    test 'when no timestamp header exist' do
      calculator = LogrageRailsRequestQueuing::RequestQueueing.new(
        { },
      )
      assert_nil(calculator.request_queued_raw)
      assert_nil(calculator.queued_ms)
    end

    test 'parsing a t=<timestamp> header from nginx' do
      calculator = LogrageRailsRequestQueuing::RequestQueueing.new(
        { 'HTTP_X_REQUEST_START' => 't=1529578997.111' },
        fake_now = 1529578998.33333
      )
      assert_equal(
        't=1529578997.111',
        calculator.request_queued_raw,
      )
      assert_equal(
        '2018-06-21T11:03:17Z',
        calculator.request_queued_at.iso8601
      )
      assert_equal(
        1222.33,
        calculator.queued_ms.round(2)
      )
    end

    test 'parsing a heroku request started header' do
      calculator = LogrageRailsRequestQueuing::RequestQueueing.new(
        { 'HTTP_X_REQUEST_START' => '1529578997111' },
        fake_now = 1529578998.33333
      )
      assert_equal(
        '1529578997111',
        calculator.request_queued_raw,
      )
      assert_equal(
        '2018-06-21T11:03:17Z',
        calculator.request_queued_at.iso8601
      )
      assert_equal(
        1222.33,
        calculator.queued_ms.round(2)
      )
    end
  end
end
