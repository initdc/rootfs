# frozen_string_literal: true

require_relative "url"
require_relative "arch"

class MyClass
  extend RootFS::Distro::Alpine
  include RootFS::Distro::Alpine
end

u = MyClass.new

MyClass::ARCH.each do |arch|
  p u.url_of("edge", arch)
end

p u.url_of
p u.url_of("3.10", "riscv64")
