require 'test_helper'

class JarFilesControllerTest < ActionController::TestCase
  setup do
    @jar_file = jar_files(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:jar_files)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create jar_file" do
    assert_difference('JarFile.count') do
      post :create, jar_file: @jar_file.attributes
    end

    assert_redirected_to jar_file_path(assigns(:jar_file))
  end

  test "should show jar_file" do
    get :show, id: @jar_file
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @jar_file
    assert_response :success
  end

  test "should update jar_file" do
    put :update, id: @jar_file, jar_file: @jar_file.attributes
    assert_redirected_to jar_file_path(assigns(:jar_file))
  end

  test "should destroy jar_file" do
    assert_difference('JarFile.count', -1) do
      delete :destroy, id: @jar_file
    end

    assert_redirected_to jar_files_path
  end
end
