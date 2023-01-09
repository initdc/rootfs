# frozen_string_literal: true

require_relative "../../parse"

module RootFS
  module Distro
    module Debian
      extend self

      # https://www.debian.org/ports/
      # https://cdimage.debian.org/cdimage/release/current/
      # https://doi-janky.infosiftr.net/job/tianon/job/debuerreotype/
      ARCH = %w[
        amd64
        arm64
        armel
        armhf
        i386
        mips64el
        mipsel
        ppc64el
        riscv64
        s390x
      ].freeze

      def parse_arch(any)
        RootFS::Parse._str_in_arr(any, "Debian", "arch", ARCH)
      end
    end
  end
end
