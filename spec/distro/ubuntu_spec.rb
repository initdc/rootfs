# frozen_string_literal: true

RSpec.describe RootFS do
  it "does something useful" do
    expect(RootFS.is_lts?(20.04)).to eq(true)
  end
end
