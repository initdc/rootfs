# frozen_string_literal: true

require_relative "stage3"

class MyClass
  extend RootFS::Distro::Gentoo
  include RootFS::Distro::Gentoo
end

g = MyClass.new

p g.parse_feature
p g.parse_feature(%w[desktop systemd])
feat = %w[armv7a hardfp systemd]
p g.parse_feature(feat)
p g.parse_feature(%w[llvm ulibc])
