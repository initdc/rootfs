# frozen_string_literal: true

require_relative "ubuntu"

class MyClass
  extend RootFS::Distro::Ubuntu
  include RootFS::Distro::Ubuntu
end

u = MyClass.new

p u.is_lts?("20.04.5")
p MyClass::CODENAME_VERSION