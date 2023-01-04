# frozen_string_literal: true

require_relative "file"

class MyClass
  extend RootFS::Distro::Gentoo
  include RootFS::Distro::Gentoo
end

u = MyClass.new

pp u.files_of
pp u.files_of("arm64", "desktop")
feat = %w[armv7a hardfp systemd]
pp u.files_of("arm", feat)
