# frozen_string_literal: true

require_relative "ubuntu"

class MyClass
  extend RootFS::Distro::Ubuntu
  include RootFS::Distro::Ubuntu
end

u = MyClass.new

p u.arch?("armv8")
p u.arch?("amd64")
p u.edition?("cloud")
p u.dev?(23.04)
p u.dev?("lunar")
p u.interim?(22.10)
p u.interim?("22.10")
p u.interim?("kinetic")
p u.lts?("focal")
p u.lts?("20.04.5")
p u.lts?("20.04")
p u.esm?(16.04)
p u.lts?("20")
p u.lts?("20.10")
p MyClass::CODENAME_VERSION
