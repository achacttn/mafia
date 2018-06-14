require 'test_helper'

class MafiasControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get mafias_new_url
    assert_response :success
  end

  test "should get create" do
    get mafias_create_url
    assert_response :success
  end

  test "should get index" do
    get mafias_index_url
    assert_response :success
  end

  test "should get show" do
    get mafias_show_url
    assert_response :success
  end

  test "should get edit" do
    get mafias_edit_url
    assert_response :success
  end

  test "should get update" do
    get mafias_update_url
    assert_response :success
  end

  test "should get destroy" do
    get mafias_destroy_url
    assert_response :success
  end

end
