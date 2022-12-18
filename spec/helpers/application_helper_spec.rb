require "rails_helper"

RSpec.describe ApplicationHelper do
  describe "#humanized_duration" do
    tests = [
      {input: 8.00, want: "8h 0m"},
      {input: 8.01, want: "8h 0m"},
      {input: 8.02, want: "8h 1m"},
      {input: 8.03, want: "8h 1m"},
      {input: 8.04, want: "8h 2m"},
      {input: 8.05, want: "8h 3m"},
      {input: 8.09, want: "8h 5m"},
      {input: 8.10, want: "8h 5m"},
      {input: 8.25, want: "8h 15m"},
      {input: 8.30, want: "8h 18m"},
      {input: 8.50, want: "8h 30m"},
      {input: 48.0, want: "48h 0m"}
    ]

    tests.each do |t|
      it "returns «#{t.fetch(:want)}» for «#{t.fetch(:input)}»" do
        expect(helper.humanized_duration(t.fetch(:input))).to eq t.fetch(:want)
      end
    end
  end
end
