# frozen_string_literal: true

require_relative "ubuntu"

class MyClass
  extend RootFS::Distro::Ubuntu
  include RootFS::Distro::Ubuntu
end

u = MyClass.new

p u.lts?("focal")
p u.lts?("20.04.5")
p u.lts?("20.04")
p u.lts?("20")
p u.lts?("20.10")
p MyClass::CODENAME_VERSION
