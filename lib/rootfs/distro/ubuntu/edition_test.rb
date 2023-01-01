# frozen_string_literal: true

require_relative "edition"

class MyClass
  extend RootFS::Distro::Ubuntu
  include RootFS::Distro::Ubuntu
end

u = MyClass.new

p u.parse_edition("fedora")
p u.parse_edition("cloud")

p u.parse_release(1)
p u.parse_release(20.04)
p u.parse_release(:focal)
p u.parse_release(22.10)
p u.parse_release(:lunar)
p u.parse_release(23.04)
