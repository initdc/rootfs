# frozen_string_literal: true

require_relative "rootfs/version"
require_relative "rootfs/distro/ubuntu"

module RootFS
  extend RootFS::Distro::Ubuntu
end
