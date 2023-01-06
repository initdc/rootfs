# frozen_string_literal: true

require_relative "file"

class MyClass
  extend RootFS::Distro::Fedora
  include RootFS::Distro::Fedora
end

u = MyClass.new

pp u.files_of
pp u.files_of("1st", 37, "aarch64")
pp u.files_of("1st", 36, "armhfp")
