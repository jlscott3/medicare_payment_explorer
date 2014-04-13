require 'test_helper'

class HcpcsControllerTest < ActionController::TestCase
  test "should get by_payment" do
    get :by_payment
    assert_response :success
  end

end
