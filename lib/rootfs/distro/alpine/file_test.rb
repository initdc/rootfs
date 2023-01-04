# frozen_string_literal: true

require_relative "file"

class MyClass
  extend RootFS::Distro::Alpine
  include RootFS::Distro::Alpine
end

u = MyClass.new

MyClass::ARCH.each do |arch|
  pp u.files_of("edge", arch)
end

pp u.files_of
pp u.files_of("3.10", "riscv64")
