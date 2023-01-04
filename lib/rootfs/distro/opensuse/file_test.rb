# frozen_string_literal: true

require_relative "file"

class MyClass
  extend RootFS::Distro::OpenSUSE
  include RootFS::Distro::OpenSUSE
end

u = MyClass.new

pp u.files_of(15.5)
pp u.files_of("alpha")
pp u.files_of(5.3)
pp u.files_of(15.0, "aarch64", "desktop")
pp u.files_of("rolling")
pp u.files_of("rolling", "aarch64")
pp u.files_of("rolling", "x86_64", "desktop")
pp u.files_of("rolling", "i686", "desktop")
pp u.files_of("rolling", "aarch64", "microos")
pp u.files_of("rolling", "aarch64", "desktop")
pp u.files_of("rolling", "riscv")
