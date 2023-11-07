class WeeksController < ApplicationController
  def edit
    prepare_entries
  end

  def update
    render json: params.to_unsafe_h
  end

  private

  def prepare_entries
    @entries = current_user.entries.for(
      year: params[:year],
      week: params[:week]
    ).to_a

    (1..5).each do |cwday|
      next if @entries.any? { |e| e.date.cwday == cwday }

      @entries << current_user.entries.create!(new_entry_defaults.merge(
        type: "Entries::General",
        date: Date.commercial(params[:year].to_i, params[:week].to_i, cwday)
      ))
    end
  end
end
