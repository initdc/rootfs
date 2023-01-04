# frozen_string_literal: true

require_relative "../../parse"

module RootFS
  module Distro
    module OpenSUSE
      extend self

      # http://download.opensuse.org/ports/
      ARCH = %w[
        x86_64
        aarch64
        armv6hl
        armv7hl
        i586
        i686
        ppc
        riscv
        zsystems
      ].freeze

      def parse_arch(any)
        RootFS::Parse._str_in_arr(any, "openSUSE", "arch", ARCH)
      end
    end
  end
end
