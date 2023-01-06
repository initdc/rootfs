# frozen_string_literal: true

require_relative "../../parse"

module RootFS
  module Distro
    module Fedora
      extend self

      # https://dl.fedoraproject.org/pub/alt/rawhide-kernel-nodebug/
      # https://arm.fedoraproject.org/
      ARCH = %w[
        x86_64
        aarch64
        armhfp
        ppc64
        ppc64le
        s390x
      ].freeze

      def parse_arch(any)
        RootFS::Parse._str_in_arr(any, "Fedora", "arch", ARCH)
      end
    end
  end
end
