require 'test_helper'

class DataEntriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @data_entry = data_entries(:one)
  end

  test "should get index" do
    get data_entries_url, as: :json
    assert_response :success
  end

  test "should create data_entry" do
    assert_difference('DataEntry.count') do
      post data_entries_url, params: { data_entry: { column_id: @data_entry.column_id, data: @data_entry.data, entry_id: @data_entry.entry_id } }, as: :json
    end

    assert_response 201
  end

  test "should show data_entry" do
    get data_entry_url(@data_entry), as: :json
    assert_response :success
  end

  test "should update data_entry" do
    patch data_entry_url(@data_entry), params: { data_entry: { column_id: @data_entry.column_id, data: @data_entry.data, entry_id: @data_entry.entry_id } }, as: :json
    assert_response 200
  end

  test "should destroy data_entry" do
    assert_difference('DataEntry.count', -1) do
      delete data_entry_url(@data_entry), as: :json
    end

    assert_response 204
  end
end
