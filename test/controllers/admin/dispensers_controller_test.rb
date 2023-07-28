# frozen_string_literal: true

require 'test_helper'

module Admin
  class DispensersControllerTest < ActionDispatch::IntegrationTest
    test 'should get new' do
      get admin_dispensers_new_url
      assert_response :success
    end

    test 'should get create' do
      get admin_dispensers_create_url
      assert_response :success
    end

    test 'should get refill' do
      get admin_dispensers_refill_url
      assert_response :success
    end
  end
end
