# frozen_string_literal: true

require_relative "url"

class MyClass
  extend RootFS::Distro::OpenSUSE
  include RootFS::Distro::OpenSUSE
end

u = MyClass.new

p u.url_of(15.5)
p u.url_of("alpha")
p u.url_of(5.3)
p u.url_of(15.0, "aarch64", "desktop")
p u.url_of("rolling")
p u.url_of("rolling", "aarch64")
p u.url_of("rolling", "x86_64", "desktop")
p u.url_of("rolling", "i686", "desktop")
p u.url_of("rolling", "aarch64", "microos")
p u.url_of("rolling", "aarch64", "desktop")
p u.url_of("rolling", "riscv")
