require 'test_helper'

class RealsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get reals_index_url
    assert_response :success
  end

end
