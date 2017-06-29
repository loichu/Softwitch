require 'test_helper'

class EditorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @editor = editors(:one)
  end

  test "should get index" do
    get editors_url
    assert_response :success
  end

  test "should get new" do
    get new_editor_url
    assert_response :success
  end

  test "should create editor" do
    assert_difference('Editor.count') do
      post editors_url, params: { editor: {  } }
    end

    assert_redirected_to editor_url(Editor.last)
  end

  test "should show editor" do
    get editor_url(@editor)
    assert_response :success
  end

  test "should get edit" do
    get edit_editor_url(@editor)
    assert_response :success
  end

  test "should update editor" do
    patch editor_url(@editor), params: { editor: {  } }
    assert_redirected_to editor_url(@editor)
  end

  test "should destroy editor" do
    assert_difference('Editor.count', -1) do
      delete editor_url(@editor)
    end

    assert_redirected_to editors_url
  end
end
