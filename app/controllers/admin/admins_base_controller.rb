# frozen_string_literal: true

module Admin
  class AdminsBaseController < ApplicationController
    before_action :authenticate

    def authenticate
      return if AdminUser.find_by(api_key: request.headers['Authorization']).present?

      render json: { message: 'Unauthorized. Only admins can create dispensers' }, status: :unauthorized
    end
  end
end
