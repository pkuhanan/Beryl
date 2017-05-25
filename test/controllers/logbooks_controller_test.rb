require 'test_helper'

class LogbooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @logbook = logbooks(:one)
  end

  test "should get index" do
    get logbooks_url, as: :json
    assert_response :success
  end

  test "should create logbook" do
    assert_difference('Logbook.count') do
      post logbooks_url, params: { logbook: { description: @logbook.description, name: @logbook.name, private: @logbook.private, user_id: @logbook.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show logbook" do
    get logbook_url(@logbook), as: :json
    assert_response :success
  end

  test "should update logbook" do
    patch logbook_url(@logbook), params: { logbook: { description: @logbook.description, name: @logbook.name, private: @logbook.private, user_id: @logbook.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy logbook" do
    assert_difference('Logbook.count', -1) do
      delete logbook_url(@logbook), as: :json
    end

    assert_response 204
  end
end
