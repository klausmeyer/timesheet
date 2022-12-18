class EntriesController < ApplicationController
  def index
    @entries = current_user.entries.sorted_for_dashboard
  end

  def new
    @entry = Entries::Base.new(type: params[:type] || "Entries::General")
  rescue ActiveRecord::SubclassNotFound
    @entry = Entries::General.new
  end

  def create
    @entry = current_user.entries.build(entry_params)

    if @entry.save
      flash.now[:success] = t(".success")

      @entries = current_user.entries.sorted_for_dashboard # FIXME: Find a better way to reload the list

      render :create
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    if current_user.entries.available.find(params[:id]).delete
      flash.now[:success] = t(".success")
    else
      flash.now[:danger] = t(".fail")
    end

    @entries = current_user.entries.sorted_for_dashboard # FIXME: Find a better way to reload the list

    render :destroy
  end

  private

  def entry_params
    params.require(:entry).permit(
      # Base
      :date,
      :type,
      # General
      :start_time,
      :end_time,
      # Manual
      :time_manual
    )
  end
end
