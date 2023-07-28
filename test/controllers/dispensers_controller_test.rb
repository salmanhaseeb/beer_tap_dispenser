# frozen_string_literal: true

require 'test_helper'

class DispensersControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get dispensers_index_url
    assert_response :success
  end

  test 'should get show' do
    get dispensers_show_url
    assert_response :success
  end

  test 'should get update' do
    get dispensers_update_url
    assert_response :success
  end
end
