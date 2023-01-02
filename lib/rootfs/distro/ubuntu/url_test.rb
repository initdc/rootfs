# frozen_string_literal: true

require_relative "url"

class MyClass
  extend RootFS::Distro::Ubuntu
  include RootFS::Distro::Ubuntu
end

u = MyClass.new

p u.url_of("desktop", 20.04)
p u.url_of("desktop", 20.04, arch: "arm64")
p u.url_of("desktop", 20.04, true, arch: "arm64")
p u.url_of("desktop", "lunar", true, arch: "arm64")
p u.url_of("desktop", 23.04, true)
p u.url_of("desktop", 22.04, true)
p u.url_of("server", 20.04)
p u.url_of("server", 20.04, true)
p u.url_of("server", 20.04, arch: "arm64")
p u.url_of("server", 20.04, true, arch: "arm64")
p u.url_of("base", 20.04)
p u.url_of("base", "focal")
p u.url_of("cloud", "focal")
p u.url_of("cloud", 22.04)
p u.url_of("minimal", 22.04)
p u.url_of("minimal", "jammy")
