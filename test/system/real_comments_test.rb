require "application_system_test_case"

class RealCommentsTest < ApplicationSystemTestCase
  setup do
    @real_comment = real_comments(:one)
  end

  test "visiting the index" do
    visit real_comments_url
    assert_selector "h1", text: "Real Comments"
  end

  test "creating a Real comment" do
    visit real_comments_url
    click_on "New Real Comment"

    fill_in "Comment", with: @real_comment.comment
    fill_in "Real", with: @real_comment.real_id
    fill_in "User", with: @real_comment.user_id
    click_on "Create Real comment"

    assert_text "Real comment was successfully created"
    click_on "Back"
  end

  test "updating a Real comment" do
    visit real_comments_url
    click_on "Edit", match: :first

    fill_in "Comment", with: @real_comment.comment
    fill_in "Real", with: @real_comment.real_id
    fill_in "User", with: @real_comment.user_id
    click_on "Update Real comment"

    assert_text "Real comment was successfully updated"
    click_on "Back"
  end

  test "destroying a Real comment" do
    visit real_comments_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Real comment was successfully destroyed"
  end
end
