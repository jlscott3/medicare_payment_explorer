require 'test_helper'

class ProvidersControllerTest < ActionController::TestCase
  test "should get by_payment" do
    get :by_payment
    assert_response :success
  end

  test "should get by_proc_frequency" do
    get :by_proc_frequency
    assert_response :success
  end

end
