# frozen_string_literal: true

require_relative "../../parse"

module RootFS
  module Distro
    module Alpine
      extend self

      # https://dl-cdn.alpinelinux.org/alpine/edge/releases/
      ARCH = %w[
        aarch64
        armhf
        armv7
        mips64
        ppc64le
        riscv64
        s390x
        x86
        x86_64
      ].freeze

      def parse_arch(any)
        RootFS::Parse._str_in_arr(any, "Alpine", "arch", ARCH)
      end
    end
  end
end
