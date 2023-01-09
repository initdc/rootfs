# frozen_string_literal: true

require_relative "file"

class MyClass
  extend RootFS::Distro::Debian
  include RootFS::Distro::Debian
end

u = MyClass.new

p u.files_of
p u.files_of("netinst", "11.6.0")
p u.files_of("netinst", "11")
p u.files_of("netinst", "11")
p u.files_of("netinst", "daily")
p u.files_of("netinst", "weekly")
p u.files_of("desktop", "11.6.0")
p u.files_of("desktop", "weekly")
p u.files_of("cloud", "11.6.0")
p u.files_of("cloud", "daily")
p u.files_of("docker", "11.6.0", build: "daily")
p u.files_of("slim", "11.6.0", build: "daily")
p u.files_of("docker", :unstable, build: "daily")
