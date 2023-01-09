# frozen_string_literal: true

require_relative "url"

class MyClass
  extend RootFS::Distro::Debian
  include RootFS::Distro::Debian
end

u = MyClass.new

p u.url_of("netinst", "11.6.0")
p u.url_of("netinst", "11")
p u.url_of("netinst", "11")
p u.url_of("netinst", "daily")
p u.url_of("netinst", "weekly")
p u.url_of("desktop", "11.6.0")
p u.url_of("desktop", "weekly")
p u.url_of("cloud", "11.6.0")
p u.url_of("cloud", "daily")
p u.url_of("docker", "11.6.0", build: "daily")
p u.url_of("slim", "11.6.0", build: "daily")
p u.url_of("docker", :unstable, build: "daily")
