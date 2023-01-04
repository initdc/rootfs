# frozen_string_literal: true

require_relative "url"
require_relative "arch"

class MyClass
  extend RootFS::Distro::Gentoo
  include RootFS::Distro::Gentoo
end

u = MyClass.new

MyClass::ARCH.each do |arch|
  p u.url_of(arch)
end

p u.url_of("riscv64")
