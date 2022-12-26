class EntriesController < ApplicationController
  def index
    @entries = current_user.entries.sorted_for_dashboard
  end

  def new
    @entry = new_entry_with_defaults
  end

  def create
    @entry = current_user.entries.build(entry_params)

    if @entry.save
      render_for_dashboard :create, :success, t(".success")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @entry = current_user.entries.available.find params[:id]
  end

  def update
    @entry = current_user.entries.available.find params[:id]

    if @entry.update(entry_params)
      render_for_dashboard :update, :success, t(".success")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if current_user.entries.available.find(params[:id]).delete
      render_for_dashboard :destroy, :success, t(".success")
    else
      render_for_dashboard :destroy, :danger, t(".fail")
    end
  end

  private

  # FIXME: Find a better way to reload the list
  def render_for_dashboard(template, flash_type, flash_value)
    @entries = current_user.entries.sorted_for_dashboard

    flash.now[flash_type] = flash_value

    render template
  end

  def entry_params
    params.require(:entry).permit(
      :date,
      :type,
      :start_time,
      :end_time,
      :time_manual
    )
  end
end
