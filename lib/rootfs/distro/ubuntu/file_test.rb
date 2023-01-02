# frozen_string_literal: true

require_relative "file"

class MyClass
  extend RootFS::Distro::Ubuntu
  include RootFS::Distro::Ubuntu
end

u = MyClass.new

p u.files_of
p u.files_of("desktop", 20.04)
p u.files_of("desktop", 23.04)
p u.files_of("desktop", "lunar")
p u.files_of("server", 20.04)
p u.files_of("base", 20.04)
p u.files_of("base", "focal")
p u.files_of("base", 20.04, "riscv64")
p u.files_of("base", "focal", "loongarch")
p u.files_of("cloud", "focal")
p u.files_of("cloud", 22.04)
p u.files_of("minimal", 22.04)
p u.files_of("minimal", "jammy")
