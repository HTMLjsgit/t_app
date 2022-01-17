require 'test_helper'

class RealCommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @real_comment = real_comments(:one)
  end

  test "should get index" do
    get real_comments_url
    assert_response :success
  end

  test "should get new" do
    get new_real_comment_url
    assert_response :success
  end

  test "should create real_comment" do
    assert_difference('RealComment.count') do
      post real_comments_url, params: { real_comment: { comment: @real_comment.comment, real_id: @real_comment.real_id, user_id: @real_comment.user_id } }
    end

    assert_redirected_to real_comment_url(RealComment.last)
  end

  test "should show real_comment" do
    get real_comment_url(@real_comment)
    assert_response :success
  end

  test "should get edit" do
    get edit_real_comment_url(@real_comment)
    assert_response :success
  end

  test "should update real_comment" do
    patch real_comment_url(@real_comment), params: { real_comment: { comment: @real_comment.comment, real_id: @real_comment.real_id, user_id: @real_comment.user_id } }
    assert_redirected_to real_comment_url(@real_comment)
  end

  test "should destroy real_comment" do
    assert_difference('RealComment.count', -1) do
      delete real_comment_url(@real_comment)
    end

    assert_redirected_to real_comments_url
  end
end
