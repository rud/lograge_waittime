require "test_helper"

module Lograge::Waittime
  class RequestStartedMiddlewareTest < ActiveSupport::TestCase
    test "middleware is installed" do
      assert Rails.application.middleware.include?(
        Lograge::Waittime::RequestStartedMiddleware
      )
    end

    test "middleware forwards .call to passed in app" do
      env = "fake env"

      fake_app = Minitest::Mock.new("fake_app")
      fake_app.expect(:call, nil, [env])

      middleware = Lograge::Waittime::RequestStartedMiddleware.new(fake_app)
      middleware.call(env)

      assert_mock fake_app
    end
  end
end
