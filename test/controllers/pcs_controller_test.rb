require 'test_helper'

class PcsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pc = pcs(:one)
  end

  test "should get index" do
    get pcs_url
    assert_response :success
  end

  test "should get new" do
    get new_pc_url
    assert_response :success
  end

  test "should create pc" do
    assert_difference('Pc.count') do
      post pcs_url, params: { pc: {  } }
    end

    assert_redirected_to pc_url(Pc.last)
  end

  test "should show pc" do
    get pc_url(@pc)
    assert_response :success
  end

  test "should get edit" do
    get edit_pc_url(@pc)
    assert_response :success
  end

  test "should update pc" do
    patch pc_url(@pc), params: { pc: {  } }
    assert_redirected_to pc_url(@pc)
  end

  test "should destroy pc" do
    assert_difference('Pc.count', -1) do
      delete pc_url(@pc)
    end

    assert_redirected_to pcs_url
  end
end
