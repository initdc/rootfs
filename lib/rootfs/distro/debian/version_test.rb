# frozen_string_literal: true

require_relative "version"

class MyClass
  extend RootFS::Distro::Debian
  include RootFS::Distro::Debian
end

u = MyClass.new

p u.parse_release("daily")
p u.parse_release("weekly")
p u.parse_release(:sid)
p u.parse_release("unstable")
p u.parse_release(:bullseye)
p u.parse_release(12)
p u.parse_release(11.6)
p u.parse_release("11.6.0")
p u.parse_release(11)
p u.parse_release(11.5)
p u.parse_release("11.5.9", build: "daily")
p u.parse_release("10", build: "weekly")
p u.parse_release("9", build: "monthly")
p u.parse_release("7")

p u.parse_desktop("gnome")
p u.parse_desktop("")

p u.parse_edition("slim")
p u.parse_edition("cloud")
