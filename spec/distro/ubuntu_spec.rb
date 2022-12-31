# frozen_string_literal: true

RSpec.describe RootFS do
  class MyClass
    extend RootFS::Distro::Ubuntu
    include RootFS::Distro::Ubuntu
  end
  
  u = MyClass.new

  it "does something useful" do
    expect(MyClass.lts?(20.04)).to eq(true)
  end

  it "does something useful" do
    expect(u.lts?(20.04)).to eq(true)
  end
end
