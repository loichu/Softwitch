require 'test_helper'

class OperatingSystemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @operating_system = operating_systems(:one)
  end

  test "should get index" do
    get operating_systems_url
    assert_response :success
  end

  test "should get new" do
    get new_operating_system_url
    assert_response :success
  end

  test "should create operating_system" do
    assert_difference('OperatingSystem.count') do
      post operating_systems_url, params: { operating_system: {  } }
    end

    assert_redirected_to operating_system_url(OperatingSystem.last)
  end

  test "should show operating_system" do
    get operating_system_url(@operating_system)
    assert_response :success
  end

  test "should get edit" do
    get edit_operating_system_url(@operating_system)
    assert_response :success
  end

  test "should update operating_system" do
    patch operating_system_url(@operating_system), params: { operating_system: {  } }
    assert_redirected_to operating_system_url(@operating_system)
  end

  test "should destroy operating_system" do
    assert_difference('OperatingSystem.count', -1) do
      delete operating_system_url(@operating_system)
    end

    assert_redirected_to operating_systems_url
  end
end
