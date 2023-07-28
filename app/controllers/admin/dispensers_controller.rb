# frozen_string_literal: true

module Admin
  class DispensersController < Admin::AdminsBaseController
    before_action :set_dispenser, only: %i[update destroy show]

    def new
      @dispenser = Dispenser.new
    end

    def create
      @dispenser = Dispenser.new(dispenser_params)
      if @dispenser.save
        render :create, status: :created
      else
        render json: @dispenser.errors, status: :unprocessable_entity
      end
    end

    def show
      dispenser_stats_service = DispenserStatsService.new(@dispenser)
      @stats = dispenser_stats_service.stats
      render :stats
    end

    def update
      if @dispenser.remaining_volume.zero?
        @dispenser.update(remaining_volume: @dispenser.total_capacity)
        render json: { message: 'Dispenser was successfully refilled.' }, status: :ok
      else
        render json: { error: 'Dispenser cannot be refilled as it is not empty.' }, status: :unprocessable_entity
      end
    end

    def destroy
      if @dispenser.destroy
        render :destroy
      else
        render json: { message: @dispenser.errors }
      end
    end

    private

    def dispenser_params
      params.require(:dispenser).permit(:flow_volume, :price_per_liter, :total_capacity)
    end

    def set_dispenser
      @dispenser = Dispenser.find(params[:id])
    end
  end
end
