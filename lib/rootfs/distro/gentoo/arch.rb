# frozen_string_literal: true

require_relative "../../parse"

module RootFS
  module Distro
    module Gentoo
      extend self

      # https://www.gentoo.org/downloads/
      ARCH = %w[
        amd64
        alpha
        arm
        arm64
        hppa
        ia64
        loong
        mips
        m68k
        ppc
        riscv
        s390
        sparc
        x86
      ].freeze

      def parse_arch(any)
        RootFS::Parse._str_in_arr(any, "Gentoo", "arch", ARCH)
      end
    end
  end
end
