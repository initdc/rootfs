# frozen_string_literal: true

require_relative "../../parse"

module RootFS
  module Distro
    module Gentoo
      extend self

      # https://www.gentoo.org/downloads/
      # https://distfiles.gentoo.org/
      FEATURE = %w[
        openrc
        systemd
        desktop
        mergedusr
        hardened
        nomultilib
        selinux
        llvm
        musl
        x32
        armv4tl
        armv5tel
        armv6j
        hardfp
        armv7a
        hppa1.1
        hppa2.0
        mips2
        mips3
        n32
        n64
        mipsel2
        mipsel3
        power9le
        ppc64le
        ppc64
        ppc
        lp64
        lp64d
        multilib
        i486
        i686
      ].freeze

      def parse_feature(any = "openrc")
        RootFS::Parse._arr_in_arr(any, "Gentoo", "feature", FEATURE)
      end
    end
  end
end
