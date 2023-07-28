# frozen_string_literal: true

class DispensersController < ApplicationController
  before_action :set_dispenser, only: %i[show update]

  def index
    @dispensers = Dispenser.all
    render json: @dispensers
  end

  def show
    render json: @dispenser
  end

  def update
    case params[:status]
    when 'open'
      @dispenser_action = DispenserService.new(@dispenser).start_pouring
      if @dispenser_action[:errors].present?
        render json: { errors: @dispenser_action[:errors] }, status: :unprocessable_entity
      else
        render :update
      end
    when 'close'
      if @dispenser.events.last.present?
        if @dispenser.events.last.event_type == 'open'
          @dispenser_action = DispenserService.new(@dispenser).stop_pouring
          render :update
        else
          render json: { error: 'Dispenser is already closed.' }, status: :unprocessable_entity
        end
      else
        render json: { error: 'Dispenser is already closed.' }, status: :unprocessable_entity
      end
    end
  end

  private

  def set_dispenser
    @dispenser = Dispenser.find(params[:id])
  end
end
