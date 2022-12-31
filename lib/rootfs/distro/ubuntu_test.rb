# frozen_string_literal: true

require_relative "ubuntu"

class MyClass
  include RootFS::Distro::Ubuntu
end

u = MyClass.new

p u.is_lts?("20.04.5")