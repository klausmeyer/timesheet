class WeeksController < ApplicationController
  def edit
    prepare_entries
  end

  def update
    Entries::Base.transaction do
      update_params.each do |id, attributes|
        current_user.entries.find(id).update!(attributes)
      end
    end

    redirect_to root_path
  end

  private

  def prepare_entries
    @entries = current_user.entries.where(
      year: params[:year],
      week: params[:week]
    ).to_a

    (1..5).each do |cwday|
      next if @entries.any? { _1.date.cwday == cwday }

      @entries << current_user.entries.create!(new_entry_defaults.merge(
        type: "Entries::General",
        date: Date.commercial(params[:year].to_i, params[:week].to_i, cwday)
      ))
    end
  end

  def update_params
    params.permit(entries: [:start_time, :end_time, :time_manual]).require(:entries)
  end
end
