require 'test_helper'

class Api::MessagesControllerTest < ActionController::TestCase
  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get channel" do
    get :channel
    assert_response :success
  end

end
